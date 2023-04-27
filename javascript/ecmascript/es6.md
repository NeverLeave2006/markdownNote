1. let
```js
    //声明格式
    let a;
    let b,c,d;
    let f=521,g='fasdfsadf',h=[]

    //1.变量不能重复声明，var可以
    //2.块级作用域 全局，函数，evel
    {
        let girl='周扬青'
    }
    console.log(girl)

    //3.不存在变量提升
    console.log(song) //只是输出undifined
    var song='value1'

    console.log(song2) //报错
    let song2='value1'

    //4.不影响作用域
    {
        let school='尚硅谷';
        function fn(){
            console.log(school)
        }
        fn();//正常输出
    }
```

2. const
```js
//声明常量
const SCHOOL='尚硅谷'

//1. 一定要赋值
//const A;
//2. 一般常量使用大写
SCHOOL='ATGUIGU'
//3. 常量值不能修改

//4.块级作用域
{
    const PLAYER='UZI'
}
console.log(PLAYER)

//5.对于数组和对象的元素修改，不算是对常量的修改，不会报错
const TEAM=['uzi','mxlg','ming'];
TEAM.push('miko');
```

3. 变量的解构赋值
```js
//数组的结构赋值
const F4=['小沈阳','刘能','赵四','宋小宝']
let [xiao,liu,zhao,song]=F4
console.log(xiao)
console.log(liu)
console.log(zhao)
console.log(song)

//对象的结构赋值
const zhao={
    name:'赵本山',
    age:'不详',
    xiaopin:function(){
        console.log('我可以演小品'); 
    }
}

// let {name,age,xiaopin}=zhao;
// console.log(name)
// console.log(age)
// console.log(xiaopin)

// xiaopin();

//或者
let {xiaopin}=zhao;
xiaopin();

```

4. 模板字符串

```js
//1.声明
// let str=`这是一个字符串`
// console.log(str,typeof str)

//2 内容中可以出现换行符

let str=`<ul>
            <li></li>
         <ul>`

//3. 可以进行变量拼接
let lovest=`魏翔`
let out=`${lovest}是我心中最搞笑的演员！！！`
console.log(out)

```

5. 简化对象写法
```js
let name='尚硅谷'
let change=function(){
    console.log('我们可以改变你');
}

// const school={
//     name: name,
//     change: change
// }
const school={
    name,
    change,
    // improve: function(){
    //     console.log('提高你的技能')
    // }
    improve(){
        console.log('提高你的技能')
    }
}
```

6. 箭头函数
```js
//1.声明一个函数
// let fn=function(){

// }

let fn=(a,b)=>{
    return a+b;
}
let result=fn(1,2)

//1.this是静态的，this始终指向函数声明时所在作用域下的值
function getName(){
    console.log(this.name);
}
let getName2=()=>{
    console.log(this.name)
}

//设置window对象的name属性
window.name='尚硅谷'
const school={
    name: "ATGUIGU"
}

getName();
getName2();

//call方法调用
getName.call(school)
getName2.call(school) //这个this值是不变的

//2.不能作为构造实例化方法，不能作为构造函数实例化对象
// let Person=(name,age) =>{
//     this.name=name;
//     this.age=age;
// }
// let me=new Person('xiao',30)
// console.log(me)


//3.不能适应arguments变量
let fn=()=>{
    consloe.log(arguments);
}
fn(1,2,3)

//4.关于箭头函数的简写
    //1.省略小括号(形参有且只有一个)
    let add=n=>{
        return n+n;
    }
    console.log(add(9));
    //省略花括号，当只有一条语句时，此时 return必须省略

```
 