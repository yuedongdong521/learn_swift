import UIKit

// raw pointer （原生指针）

var str = "Hello, playground"

func swiftLog(_ items:Any ...) {
    print("\(Date.init(timeIntervalSinceNow: 8 * 3600)) : \(items)")
}

let count = 2
let stride = MemoryLayout<Int>.stride  // 步长，Int 8个字节
let aligment = MemoryLayout<Int>.alignment // 对齐内存大小，步长最大值
let byteCount = stride * count // 实际需要内存大小

// 2 使用 do 来增加一个作用域，让我们可以在接下的示例中复用作用域中的变量名。
do {
    // 原生raw 指针
    swiftLog("raw pointers")
    // 3  通过实际内存和对齐内存初始化Int原生指针
    let pointer = UnsafeMutableRawPointer.allocate(byteCount: byteCount, alignment: aligment)
    
    // 4 延时释放，使用defer在正确的时机安全释放指针内存，指针内存需要手动管理
    defer {
        swiftLog("defer")
        pointer.deallocate()
    }
    let intMax = Int(1024.0)
    
    // 5 存储字节 of:存入的值, as:值得类型
    pointer.storeBytes(of: intMax, as: Int.self)
    // 移动指针的地址（一个步长的位置），并存入第二个值
    pointer.advanced(by: stride).storeBytes(of: 6, as: Int.self)
    // 读取第一个值
    let fristValue = pointer.load(as: Int.self)
    swiftLog("fristValue : \(fristValue)")
    // 读取第二个值
    let secondValue = pointer.advanced(by: stride).load(as: Int.self)
    swiftLog("secondValue \(":") \(secondValue)")
    // 6 UnsafeRawBufferPointer 类型以字节流的形式来读取内存。这意味着我们可以这些字节进行迭代，对其使用下标，或者使用 filter，map 以及 reduce 这些很酷的方法，缓冲类型指针使用了原生指针进行初始化。
    let bufferPointer = UnsafeRawBufferPointer(start: pointer, count: byteCount)
    for (index, byte) in bufferPointer.enumerated() {
        swiftLog("bute \(index): \(byte)")
    }
}

print("********************** \n********************")

print("类型指针")

do {
    print("Type pointers")
    // 类型指针，在分配内存的时候通过给范型赋值来指定当前指针所操作的数据类型
    // count：要存储的数据个数
    let pointer = UnsafeMutablePointer<Int>.allocate(capacity: count)
    // 类型指针单单分配内存，还不能使用，还需要初始化, repeatedValue：默认值 count：数量
    pointer.initialize(repeating: 0, count: count)
    
    defer {
        swiftLog("defer")
        // 在释放的时候，要先释放已初始化的实例(deinitialize)，再释放已分配的内存(deallocate)空间：
        // count 数量
        pointer.deinitialize(count: count)
        pointer.deallocate()
    }
    
    // 类型指针的存储/读取值，不需要再使用storeBytes/load，Swift提供了一个以类型安全的方式读取和存储值--pointee
    pointer.pointee = 42
    // n：这里是按类型值的个数进行移动
    pointer.advanced(by: 1).pointee = 6
    pointer.pointee
    
    pointer.advanced(by: 1).pointee
    // 同样，这里也可以使用运算符 + 进行移动
   (pointer + 1).pointee
    
    let bufferPointer = UnsafeBufferPointer(start: pointer, count: count)
    for (index, value) in bufferPointer.enumerated() {
        swiftLog("value \(index) : \(value)")
    }
}

print("********************** \n********************")

print("原生指针转换为类型指针")

do {
    swiftLog("Converting raw pointers to typed pointers")
    let rawPointer = UnsafeMutableRawPointer.allocate(byteCount: byteCount, alignment: aligment)
    defer {
        rawPointer.deallocate()
    }
    // 原生指针转换为类型指针，是通过调用内存绑定到特定的类型来完成的：type : 数据类型， count ： 容量
    // 通过对内存的绑定，我们可以通过类型安全的方法来访问它。
    // 其实我们手动创建类型指针的时候，系统自动帮我们进行了内存绑定。
    let typePointer = rawPointer.bindMemory(to: Int.self, capacity: count)
    typePointer.initialize(repeating: 0, count: count)
    defer {
        typePointer.deinitialize(count: count)
    }
    typePointer.pointee = 42
    typePointer.advanced(by: 1).pointee = 9
    typePointer.pointee
    typePointer.advanced(by: 1).pointee
    
    let bufferPoint = UnsafeBufferPointer(start: typePointer, count: count)
    
    for (index, value) in bufferPoint.enumerated() {
        swiftLog("value \(index) : \(value)")
    }
}

print("********************** \n********************")

print("获取一个实例的字节")
struct Sample {
    var number: Int  // stride ： 8
    var flag: Bool  // stride ： 1
    init(number: Int, flag: Bool) {
        self.number = number
        self.flag = flag
    }
}

do {
    print("Getting the bytes of an instance")
    var sample = Sample(number: 25, flag: true)
    // 使用了withUnsafeBytes 方法来实现获取字节数：
    // arg：实例对象地址 body：回调闭包，参数为UnsafeRawBufferPointer 类型的指针
    // 注意：该方法和回调闭包都有返回值，如果闭包有返回值，此返回值将会作为该方法的返回值；
    // 但是，一定不要在闭包中将body的参数，即：UnsafeRawBufferPointer 类型的指针作为返回值返回，
    // 该参数的使用范围仅限当前闭包，该参数的使用范围仅限当前闭包，该参数的使用范围仅限当前闭包。
    withUnsafeBytes(of: &sample) { (rs) in
        for bute in rs {
            swiftLog(bute)
        }
    }
    // withUnsafeBytes 同样适合用 Array 和 Data 的实例.
}

/*
 使用指针的原则
 不要从 withUnsafeBytes 中返回指针
 绝对不要让指针逃出 withUnsafeBytes(of:) 的作用域范围。这样的代码会成为定时炸弹，你永远不知道它什么时候可以用，而什么时候会崩溃。
 一次只绑定一种类型
 在使用 bindMemory方法将原生指针绑定内存类型，转为类型指针的时候，一次只能绑定一个类型，例如：将一个原生指针绑定Int类型，不能再绑定Bool类型：
 let typePointer = rawPointer.bindMemory(to: Int.self, capacity: count)
 // 一定不要这么做
 let typePointer1 = rawPointer.bindMemory(to: Bool.self, capacity: count)
 
 但是，我们可以使用 withMemoryRebound 来对内存进行重新绑定。并且，这条规则也表明了不要将一个基本类型(如 Int)重新绑定到一个自定义类型(如 class)上。
 
 public func withMemoryRebound<T, Result>(to type: T.Type, capacity count: Int, _ body: (UnsafeMutablePointer<T>) throws -> Result) rethrows -> Result
 
 type：值的类型
 count：值的个数
 body：回调闭包，参数为UnsafeRawBufferPointer 类型的指针
 
 注意：该方法和回调闭包都有返回值，如果闭包有返回值，此返回值将会作为该方法的返回值；但是，一定不要在闭包中将body的参数，即：UnsafeRawBufferPointer 类型的指针作为返回值返回，该参数的使用范围仅限当前闭包，该参数的使用范围仅限当前闭包，该参数的使用范围仅限当前闭包。

*/


print("********************** \n********************")

print("不要操作超出范围的内存")

do {
    let count = 3
    let stride = MemoryLayout<Int16>.stride
    let alignment = MemoryLayout<Int16>.alignment
    let byteCount = count * stride
    
    let pointer = UnsafeMutableRawPointer.allocate(byteCount: byteCount, alignment: alignment)
    // count+1，超出了原有指针pointer分配的内存范围，切记不要出现这种情况
    let bufferPointer = UnsafeRawBufferPointer.init(start: pointer, count: count + 1)
    for byte in bufferPointer {
        print(byte)
    }
}


print("********************** \n********************")

print("Students test")

struct Students {
    var name : String
    var id : Int
    func myName() {
        swiftLog("my name is " + name)
    }
}

do {
    var ydd = Students(name: "ydd", id: 25)
    let count = MemoryLayout<Students>.stride
    swiftLog("Students count : \(count)")
    withUnsafeBytes(of: &ydd) { (stud) in
        for (index, value) in stud.enumerated() {
            let char = Character.init(UnicodeScalar.init(value))
            let str = String.init(char)
            swiftLog("index : \(index), value : \(value) str : " + str)
        }
    }
}



