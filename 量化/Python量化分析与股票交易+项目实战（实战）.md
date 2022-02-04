# 需求：股票分析
- 使用tushare包获取某股票的历史行情数据
- 输出该股票所有收盘比开盘上涨3%以上的日期
- 输出该股票所有开盘比前日跌幅超过2%的日期
- 加入我从2010年1月1日开始,每月第一个交易日买入1受股票,每年最后一个交易日卖出所有股票,到今天为止,我的收益如何?

- tushare财经数据接口包
  - pip install tushare

```python
import tushare as ts
import pandas as pd
from pandas import DataFrame,Series
import numpy as np

#获取某只股票的历史行情数据
#code字符串形式的股票代码
df=ts.get_k_data(code="601988",start='2000-01-01')

# 将互联网上获取的股票数据存储到本地
df.to_csv("中国银行.csv")# 调用to_xxx将df中的数据写入本地进行存储

df=pd.read_csv("中国银行.csv")
df.head()
# 删除df中指定的一列
df.drop(labels="Unnamed: 0",axis=1,inplace=True)
# 查看每一类的数据类型
df.info
# 将time类转为时间序列类型
df['date']=pd.to_datetime(df['date'])
# 将date列作为元数据的行索引
df.set_index('date',inplace=True)
df.head()

#############################################
# 输出该股票所有收盘比开盘上涨3%以上的日期
# (收盘-开盘)/开盘>0.03

(df['open']-df['close'])/df['open']>0.03
# 在分析过程中如果产生了bool值,下一步马上将bool值作为源数据的行索引
    # 如果布尔值作为df的行索引,则可以取出true对应的行数据，忽略false对应的行数据
df.loc[(df['open']-df['close'])/df['open']>0.03]# 获取了true对应的行数据(满足需求的行数据)
df.loc[(df['open']-df['close'])/df['open']>0.03].index # df的行数据

#############################################
# 输出该伪代码所有比前日收盘跌幅超过2%的日期
# 伪代码:(开盘-前日收盘)/前日收盘 <-0.02
(df['open']-df['close'].shift(1))/df['close'].shift(1)<-0.02
# 将bool值作为源数据的行索引取出True对应的行数据
df.loc[(df['open']-df['close'].shift(1))/df['close'].shift(1)<-0.02].index

#############################################
new_df=df['2010-01':'2021-05']
new_df
# 买股票：找到每个月的第一个交易日对应的数据(捕获到开盘价)-->每月的第一行数据
# 根据月份从原始数据中提前指定的数据
# 每月第一个交易日对应的行数据
df_monthly=new_df.resample('M').first() # 数据的重新取样
df_monthly

# 买入股票花费的总金额
cost=df_monthly['open'].sum()*100
cost
# 卖股票到手的钱
# 特殊情况：2020年买入的股票卖不出去
new_df.resample('A').last()
#将2020年最后一行切出去
df_yearly=new_df.resample('A').last()[:-1]

# 卖出股票到手的钱
resv=df_yearly['open'].sum()*1200
resv

# 最后手中剩余的股票估价计算到总收益中
# 使用昨天的收盘价为剩余股票的单价
last_money=600*new_df['close'][-1]
# 计算总收益
resv+last_money-cost

```

- 需求：假如我从2010年1月1日1开始,每月第一个交易日买入一手股票,每年最后一个交易日卖出所有股票,到今天为止,我的收益如何？
- 分析：
    - 时间节点：2010-2020
    - 一手股票：100股
    - 买：
        - 一个完整的年需要买入1200支股票
    - 卖：
        - 一个完整的年需要卖出多少支股票?
    - 买卖股票的单价:
        - 开盘价

# 需求: 双均线策略的制定
- 使用tushare包获取某股票的历史行情数据
- 计算该支股票的5日均线和60日均线
  -  什么是均线?
     -  对于每一个交易日都可以计算出前N天的移动平均值,然后把这些移动平均值连起来,成为一条线,就叫做N日移动平均线,移动平均线常用线有5天,10天,30天,50天,120天和240天的指标。
     -  5天和10天是短线操作的参照指标,称作日均线指标：
     -  30天和60天是中期均线指标,称作季均线指标：
     -  120天和240天的是长期均线指标,称作年均线指标。
  -  均线计算方法:MA=(C1+C2+...+CN)/N C:某日收盘价 N:移动平均周期(天数)

```python
import tushare as ts
import pandas as pd
from pandas import DataFrame,Series
import numpy as np

#获取某只股票的历史行情数据
#code字符串形式的股票代码
df=ts.get_k_data(code="601988",start='2000-01-01')

# 将互联网上获取的股票数据存储到本地
df.to_csv("中国银行.csv")# 调用to_xxx将df中的数据写入本地进行存储

df=pd.read_csv("中国银行.csv")
df.head()
# 删除df中指定的一列
df.drop(labels="Unnamed: 0",axis=1,inplace=True)
# 查看每一类的数据类型
df.info
# 将time类转为时间序列类型
df['date']=pd.to_datetime(df['date'])
# 将date列作为元数据的行索引
df.set_index('date',inplace=True)
df.head()

########################################
#5日均线
ma5=df['close'].rolling(5).mean()
#30日均线
ma30=df['close'].rolling(30).mean()

#均线图像
# import matplotlib.pyplot as plt
# %matplotlib inline
# plt.plot(ma5[50:200])
# plt.plot(ma30[50:200])

ma5=ma5[30:]
ma30=ma30[30:]
s1=ma5<ma30
s2=ma5>ma30

df=df[30:]

death_ex=s1 & s2.shift(1)#判断死叉的条件
death_date=df.loc[death_ex].index

gold_ex=s1 | s2.shift(1)#判断金叉的条件
gold_date=df.loc[gold_ex].index

```
