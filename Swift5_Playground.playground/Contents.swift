import UIKit

var str = "Hello, playground"

let switchValue = "value1"
switch switchValue {
case "value0":
    print("value 0")
case "value1":
    print("value 1")
case "value2":
    print("value2")
default:
    print("default")
}

let numDic = ["key1" : [1,2,3],
              "key2" : [4,6,7],
              "key3" : [8,9,0]]
var maxValue = 0
for (_, numbers) in numDic {
    for number in numbers {
        maxValue = maxValue > number ? maxValue : number;
    }
}
print("maxValue : \(maxValue)")

var n = 0
var count1 = 0
while n < 100 {
    n += 1
    count1 += 1
}
print("while n : \(n) count1 :\(count1)")

var m = 0
var count2 = 0
repeat {
    m += 1
    count2 += 1
} while m < 100

print("repeat while : \(m) count2 :\(count2)")

var total = 0
for i in 0..<4 {
    total += i
}
print("total : \(total)")

var total2 = 0
for i in 0...4 {
    total2 += i
}
print("total : \(total2)")


func returnFifteen() -> Int {
    var y = 10
    func add() {
        y += 5
    }
    add()
    return y
}
print("func value : \(returnFifteen())")
// 函数作为返回值
func makeIncrementer() -> ((Int) -> Int) {
    func addOne(number:Int) -> Int {
        print("func name : addOne")
        return 1 + number
    }
    return addOne
}

var increment = makeIncrementer()
let funcValue = increment(7)
print("funcValue : \(funcValue)")

// 函数作为参数
func hasAnyMatches(list : [Int], condition:(Int) -> Bool) -> Bool
{
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}

func lessThanTen(number : Int) -> Bool {
    return number < 10
}

var numberList = [20, 19, 7, 12]
let isLessThanTen = hasAnyMatches(list: numberList, condition: lessThanTen(number:))
print("is lessThan 10 : \(isLessThanTen)")


var newList =  numberList.map({ (number : Int) -> Int in
    let result = 3 * number
    return result
})

print("newList : \(newList)")

var sortList = numberList.sorted{$0 < $1};

print("sortlist : \(sortList)")

protocol StudentProtocol {
//    var obj:Students { get set }
    func doSamething()
}

struct Students {
    var name:String?
    var id:Int
    func doSomething() {
        print("my name is " + (name ?? "无名"))
    }
}

struct YDD : StudentProtocol {
    var obj: Students
    
    func doSamething() {
        print("my name is " + (obj.name ?? "无名"))
    }
}

let dd = Students(name: "ydd", id: 25)
let ydd = YDD(obj: dd)

ydd.doSamething()

dd.doSomething()
var wyy = ydd
wyy.obj.name = "wyy"
wyy.doSamething()
ydd.doSamething()




