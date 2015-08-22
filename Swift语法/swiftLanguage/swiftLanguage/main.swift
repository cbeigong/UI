//
//  main.swift
//  swiftLanguage
//
//  Created by clm on 15/8/20.
//  Copyright (c) 2015年 clm. All rights reserved.
//

import Foundation

println("Hello, World!")
//使用 let 来声明常量,使用 var 来声明变量。

var explicitDouble: Double = 70

// Swift 还增加了 Objective-C 中没有的高阶数据类型比如元组(Tuple)。

// 你可以在一行中定义多个同样类型的变量,用逗号分割,并在最后一个变量名之后添加类型标注:
 var red, green, blue: Double

// 常量与变量名不能包含数学符号,箭头,保留的(或者非法的)Unicode 码位,连线与制表符。也不能以数字开 头,但是可以在常量与变量名的其他地方包含数字。
// 一旦你将常量或者变量声明为确定的类型,你就不能使用相同的名字再次进行声明,或者改变其存储的值的类
//型。同时,你也不能将常量与变量进行互转。

var friendlyWelcome = "Bonjour!"
//print(_:) 将会输出内容 到“console”面板上。(另一种函数叫 print(_:appendNewline:) ,唯一区别是在输出内容最后不会换行。)
print("This is a string")

print("The current value of friendlyWelcome is \(friendlyWelcome)")

//与 C 语言多行注释不同,Swift 的多行注释可以嵌套在其它的多行注释之中。你可以先生成一个多行注释块,然 后在这个注释块之中再嵌套成第二个多行注释。终止注释时先插入第二个注释块的终止标记,然后再插入第一个 注释块的终止标记:
// 有一种情况下必须要用分号,即你打算在同一行内写多条独立的语句:

let cat = "?";


//let maxValue = UInt8.max // maxValue 为 255,是 UInt8 类型
//lel minValue = UInt8.min // minValue 为 0,是 UInt8 类型

//你可以访问不同整数类型的 min 和 max 属性来获取对应类型的最大值和最小值:
let minValue = UInt8.min // minValue 为 0,是 UInt8 类型
let maxValue = UInt8.max // maxValue 为 255,是 UInt8 类型

// 尽量不要使用UInt


//Swift 是一个类型安全(type safe)的语言。类型安全的语言可以让你清楚地知道代码要处理的值的类型。如果 你的代码需要一个 ￼ ,你绝对不可能不小心传进去一个 ￼ 。

//当推断浮点数的类型时,Swift 总是会选择 Double 而不是 Float 。


let oneMillion = 1_000_000

//SomeType(ofInitialValue) 是调用 Swift 构造器并传入一个初始值的默认方法。在语言内部, UInt16 有一个构 造器,可以接受一个 UInt8 类型的值,所以这个构造器可以用现有的 UInt8 来创建一个新的 UInt16 。注意,你 并不能传入任意类型的值,只能传入 UInt16 内部有对应构造器的值。不过你可以扩展现有的类型来让它可以接收 其他类型的值(包括自定义类型)


let three = 3
let pointOneFourOneFiveNine = 0.14159
let pi = Double(three) + pointOneFourOneFiveNine

//当用这种方式来初始化一个新的整数值时,浮点值会被截断。也就是说 4.75 会变成 4 , -3.9 会变成 -3 。
let integerPi = Int(pi)
println(integerPi)

//类型别名(type aliases)就是给现有类型定义另一个名字。你可以使用 typealias 关键字来定义类型别名。

typealias AudioSample = UInt16

var maxAmplitudeFound = AudioSample.min

let orangesAreOrange = true

let turnipsAreDelicious = false

if turnipsAreDelicious {
    print("Mmm, tasty turnips!")
} else {
print("Eww, turnips are horrible.")
}

//如果你在需要使用 Bool 类型的地方使用了非布尔值,Swift 的类型安全机制会报错。下面的例子会报告一个编译

//元组(tuples)把多个值组合成一个复合值。元组内的值可以是任意类型,并不要求是相同类型。



let http404Error = (404, "Not Found")

let (statusCode, statusMessage) = http404Error

print("the statusCode is \(statusCode)")
print("statusErr is \(statusMessage)")

let (justTheStatusCode, _) = http404Error
print("The status code is \(justTheStatusCode)")

print("The status code is \(http404Error.0)")
print("The status message is \(http404Error.1)")

// 你可以在定义元组的时候给单个元素命名:

let http200Status = (statusCode: 200, description: "OK")

print("The status code is \(http200Status.statusCode)")

print("The status message is \(http200Status.description)")

// 到第53页

