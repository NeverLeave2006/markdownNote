# 业务任务

## 描述

业务任务通常是用来调用业务系统， commander中可以调用Java代码或者rest API调用。

## 业务任务分类

在commander中，业务任务实现方式有五种，本节先用一个小例子显示前三种， external外部任务，connector连接器后面分别讲解

1. Java Class
2. Expresion
3. Delegate expression
4. External
5. Connnector

## 需求

假设用户预约电子公司上门维修家电，然后师傅上门维修，完成后公司回访客户对师傅服务打分，师傅查询自己的评分

### 流程设计

1. 预约维修

使用Java class模式实现业务任务

