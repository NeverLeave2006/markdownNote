# 什么是数据分析
- 是把隐藏在一些看似杂乱无章的数据背后的信息提炼出来,总结所研究对象的内在规律
  - 使数据的价值最大化
    - 分析用户的消费行为
      - 指定促销活动的方案
      - 指定促销时间和粒度
      - 计算用户的活跃度
      - 分析产品的回购力度
    - 分析广告点击率
      - 决定投放时间
      - 指定广告定向人群方案
      - 决定相关平台投放
    - ...
- 数据分析使用适当的方法对手机来的大量数据进行分析，帮助人们做出判断,以便采取适当的行动
  - 保险公司从大量赔付申请数据中判断哪些行为骗保的可能
  - 支付宝通过从大量用户的消费记录和行为自动调整花呗的额度
  - 短视频平台通过用户的点击和观看行为数据针对性的给用户推送喜欢的视频

# 为什么学习数据分析
- 有岗位的需求
  - 数据竞赛平台
- 是Python数据科学的基础
- 是机器学习课程的基础

# 数据分析实现流程
- 提出问题
- 准备数据
- 分析数据
- 活动结论
- 成果可视化

# 课程内容介绍
- 基础模块使用学习
- 项目实现
- 金融量化


# 课程内容介绍
- 基础模块使用学习
- 项目实现
- 金融量化

# 开发环境介绍
- anaconda
  - 官网: [https://www.anaconda.com/](https://www.anaconda.com/)
  - 集成环境: 集成好了数据分析和机器学习中所需要的全部环境
- jupyter
  - jupyter就是anaconda提供的一个基于浏览器的可视化开发工具
- juputer的基本使用
  - 启动: 在终端中录入`jypyter notebook`的指令,按下回车
  - 新建:
    - python3: anaconda中的一个源文件
    - cell有两种模式:
      - code： 编写代码(默认)
      - markdown: 编写笔记
    - 快捷键：
      - 添加cell: `a`上方插入cell,`b`下方插入cell
      - 删除: `x`
      - 修改cell的模式:
        - `m`: markdown模式
        - `y`: code模式
      - 执行cell:
        - `shift`+`enter`
      - `tab`:自动补全
      - 打开帮助文档
        - `shift`+`tab`
```python
print("hello")
```

# 数据分析三剑客
- numpy(前提)
- pandas(重点)
- matplotlib

## numpy模块
- NumPy(Numerical Python)是Python语言中做科学计算的基础库。重在于数值计算,也是大部分Python科学计算库的基础,多用于在大型,多维数组上执行数值计算.

## NumPy的创建
- 使用np.rray()创建
- 使用plt创建
- 使用np的routines函数创建

- 使用array()函数创建一个一维数组
```python
import numpy as np
arr=np.array([1,2,3])
arr
```

- 使用array()函数创建一个多维数组
```python
import numpy as np
arr=np.array([[1,2,3],[4,5,6]])
arr
```

- 数组和列表的区别是什么?
```python
import numpy as np
arr=np.array([1,2.2,'thress'])
arr
```
  - 数组中存储的数据元素类型必须是统一类型
  - 优先级:
    - 字符串>浮点型>整数

- 将外部的一张图片加载到numpy数组中,然后尝试改变数组元素的值查看对原始数据的影响
```python
import matplotlib.pyplot as plt
img_arr=plt.imread('./nana.jpg')# 返回的数组，数组中装载的是图片内容
img_arr=255-img_arr #负片效果
plt.imshow(img_arr)
```

- zero()
- ones()
```python
np.ones(shape=(3,4))# 三行四列的元素为1的数组
```
- linspace()
```python
np.linspace(0,100,num=20)# 一维的等差数列数组
```
- arange()
```python
np.arange(10,50,step=2)# 10到50公差为2的一维数组,不包含50
```
- random()
```python
np.random.randint(0,100,size=(5,3))# 5行3列的随机二维数组
```

numpy的常用属性
- shape
- ndim
- size
- dtype

```python
import numpy as np

arr=np.random.randint(0,100,size=(5,6))
arr.shape # 返回数组形状
arr.ndim  # 数组维度
arr.size  # 返回数组元素个数
arr.dtype # 返回数组元素的类型
type(arr) # 数组的数据类型
```

指定数组元素类型
```python
import numpy as np

# 创建一个数组,指定数组元素为int64
arr=np.array([1,2,3],dtype='int64')
arr.dtype
```

直接修改数组元素类型
```python
import numpy as np

# 创建一个数组,修改数组元素为int64
arr=np.array([1,2,3],dtype='int64')
arr.dtype='uint8'
```

numpy的索引和切片操作(重点)
- 索引操作和列表同理
```python
import numpy as np

arr=np.random.randint(0,100,size=(5,6))
arr[1] #取出了numpy数组中下表为1的行数据
arr[[1,3,4]] #取出多行数据
arr[0:2] #切出arr数组前两行的数据
arr[:,0:2] #切出arr数组中的前两列 arr[行切片:列切片]
arr[0:2,0:2] # 切出前两行的前两列
arr[::-1] #将数组的行倒置
arr[:,::-1] #将数组的列倒置
```
- 切片操作
  - 切出前两列数据
  - 切出前两行数据
  - 切出前两行的前两列数据
  - 数组数据翻转
  - 练习: 将一张图片上下左右进行翻转操作
  - 练习：将图片进行指定区域的裁剪

```python
import matplotlib.pyplot as plt
img_arr=plt.imread('./nana.jpg')# 返回的数组，数组中装载的是图片内容
# 将一张图片进行左右翻转
plt.imshow(img_arr[:,::-1,:])# img_arr[行,列,颜色]
# 将一张图片进行上下翻转
plt.imshow(img_arr[::-1,:,:])# img_arr[行,列,颜色]
# 图片裁剪的功能
plt.imshow(img_arr[0:800,0:600,:])# img_arr[行,列,颜色]
```

变形reshape
```python
import numpy as np

arr=np.random.randint(0,100,size=(5,6))
# 将多维变形为一维
arr1=arr.reshape((30,))
arr1
# 将多维变形为一维
arr2=arr1.reshape((3,10))
arr2
```

级联操作
  - 将多个numpy数组进行横向或者纵向的拼接
- axis轴向的理解
  - 0: 列
  - 1: 行
- 问题:
  - 级联的两个数组维度一样,但是行列个数不一样会如何?

```python
# 将两个矩阵拼接在一起，axis=0上下拼接（行级联），axis=1左右拼接（列级联）
np.concatenate((arr,arr),axis=0)
```

聚合
```python
# 求和,axis表示行列分别求和
arr.sum(axis=1)

# 求最大值
arr.max(axis=1)
```
常用数学函数
- NumPy提供了标准的三角函数: sin(),cos()，tan()
- numpy.around(a,decimals)函数返回指定数字的四舍五入
  - 参数说明
    - a: 数组
    - decimals: 舍入的小数位数,默认值为0。如果结果为负。整数将四舍五入到小数点左侧的位置


```python
np.sin(arr)
np.around(3.84)
```

常用统计函数
- numpy.amin()和numpy.amax(),用于计算数组中的元素沿指定轴的最小，最大值.
- numpy.ptp()计算数组中元素最大值与最小值的差(最大值-最小值)
- numpy.median()函数用于计算数组a中元素的中位数(中值)
- 标准差std():标准差是一组数据平均值分散程度的一种度量.
  - 公式:std=sqrt(mean((x-x.mean())**2))
  - 如果数组是[1,2,3,4], 则其平均值为2.5。因此,差的平方是[2.25,0.25,0.25,2.25]，并且其平均值的平方根除以4。即sqrt(5/4),结果为1.118033987498949。
- 方差var():统计中的方差(样本方差)是每个样本值与全体样本值的平均数之差的平方值的平均数,即mean((x-x.mean())**2).换句话说,标准差是方差的平方根.


矩阵相关
- Numpy中包含了一个矩阵numpy.matlib。该模块中的函数返回的是一个矩阵,而不是ndarray对象,一个矩阵是一个由行(row)和列(column)元素排列成的矩阵阵列.
- numpy.matlib。identuty()函数返回指定大小的单位矩阵.单位矩阵是个方阵，从左上角到右下角的对角线(称为主对角线)上的元素均为1,除此以外全都是0.

```python
# eye返回一个标准的单位矩阵
np.eye(6)
```
- 转置
  - T

```python
# 矩阵转置,行变成列，列变成行
np.eye(6).T
```

- 矩阵相乘
  - numpy.dot(a,b,out=None)
    - a: ndarray数组
    - b: ndarray数组
    - 刚学的时候,还蛮简单的,矩阵加法就是相同位置的数字相加一下.
    - 矩阵乘法也类似
    - 矩阵乘以一个数,就是所有位置都乘以这个数
    - 但是到矩阵乘以矩阵的时候一切就不一样了

- 第一个矩阵的第一行数字(2和1)


矩阵点乘
```python
import numpy as np
a1=np.array([[1,2],[4,3]])
a2=np.array([[1,2],[1,0]])
np.dot(a1,a2)

```

# pandas基本操作
## 为什么学习pandas 
- numpy已经可以帮我们进行数据的处理了,那么学习pandas的目的是什么呢?
  - numpy能够帮助我们处理的是数值型数据,当然在数据分析中除了数值型的数据还有好多其他类型的数据(字符串,时间序列),那么pandas就可以帮我们很好的处理除了数值型的其他数据

## 什么是pandas
- 首先来认识pandas中的两个常用的类
  - Series
  - DataFrame

## Series
- Series是一种类似于一维数组的对象,由下面两个部分组成:
  - values： 一组数据(ndarry类型)
  - index：   相关数据索引标签

- Series的创建
  - 由列表或numpy数组创建
  - 由字典创建

```python
from pandas import Series
s=Series(data=[1,2,3,'four'])
s
```

```python
import numpy as np
s=Series(data=np.random.randint(0,100,size=(3,)))
#index是用来指定显示索引的
s=Series(data=[1,2,3,'four'],index=['a','b','c','d'])
s
```

```python
dic={
    '语文':100,
    '数学':99,
    '理综':250
}
a=Series(data=dic)

# 获取值或者属性的方法
a.语文
a[0]
a[0:2]
a.shape
a.size
a.index
a.values
a.dtype
```

- Series的常用方法
  - head(),tail()
  - unique()
  - isnull(),notnull()
  - add(),sub(),mul(),div()

```python
a.tail(2)# 显示后n个元素
a.head(2)# 显示前n个元素
a.unique()# 去重
a.isnull()# 判断每个元素是否为null
a.notnull()# 每个元素是否非空，与上面相反
```

- Series的运算
  - 法则:索引一致的元素进行算数运算，否则补空

## DataFrame

- DataFrame是一个【表格型】的数据结构。 DataFrame由按照一定顺序排列的多列数据组成。设计的初衷是将Series的使用场景从一位扩展到多维。DataFrame既有行索引，也有索引。
  - 行索引：index
  - 列索引：columns
  - 值：values

- DataFrame的创建
  - ndarray创建
  - 字典创建

- DataFrame的属性
  - values, columns, index, shape

```python
from pandas import DataFrame
import numpy as np
df=DataFrame(data=[[1,2,3],[4,5,6]])
df
df2=DataFrame(data=np.random.randint(0,100,size=(6,4)))
df2
dic={
    'name':['zhangsan','lisi','wanglaowu'],
    'salary':[1000,2000,3000]
}
df3=DataFrame(data=dic)
df3
df4=DataFrame(data=dic,index=['a','b','c'])
df4
```

```python
##DataFrame属性
df.values
df.columns
df.index
df.shape
df.dtype# 只能取列或者行看属性
```

```python
dic={
    '张三':[150,10,150,150],
    '李四':[0,0,0,0]
}
df=DataFrame(data=dic,index=['语文','数学','英语','理综'])
df
```


- DateFrame索引操作
  - 对行进行操作
  - 对列进行索引
  - 对元素进行索引

```python
from pandas import DataFrame
import numpy as np
df=DataFrame(data=np.random.randint(60,100,size=(8,4)),columns=['a','b','c','d'])
df['a']#取单列,如果df有显示的索引,通过显示索引机制去取行或者列的时候只可以使用显示索引

df[['a','c']]

df.iloc[0]# 取单行
df.iloc[[0,3,5]]# 取多行
```

- iloc:
  - 通过隐式索引取行
- loc:
  - 通过显式索引取行

- DataFrame的切片操作
  - 对行进行切片
  - 对列进行切片

```python
# 切行
df[0:2]
切列
df.iloc[:,0:2]
```

- df的索引和切片操作
  - 索引:
    - df[col]: 取列
    - df.loc[index]: 取行
    - df.iloc[index,col]:取元素
  - 切片:
    - df[index1:index3]:切行
    - df.iloc[:,col1:col3]切列


- DataFrame的运算
  - 同Series

=========================================================
练习：
  1. 假设add是期中考试成绩,add2是期末考试成绩,请由创建add2并将其与ddd相加,求期中期末平均值。
  2. 假设张三期中考试数学被发现作弊,要记为0分,如何实现?
  3. 李四因为举报张三作弊立功,期中考试所有科目加100分,如何实现?
  4. 后来老师发现有一道题出错了,为了安抚学生情绪,给每个学生每个科目加10分,如何实现?
=========================================================


- 时间数据类型的转换
  - pd.to_datetime(col)
- 将某一列设置为行索引
  - df.set_index()

```python
## 查看time列的类型
df['time'].dtype
# 将time列的数据类型转换为时间序列类型
import pandas as pd
pd.to_datetime(df['time'])

# 将time作为元数据行索引
df.set_index('time')
```

