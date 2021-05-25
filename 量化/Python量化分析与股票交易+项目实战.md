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