import UIKit

var str = "Hello, playground"

protocol ActiveProtocol {
    var type : String { get }
    var name : String { get }
    // 1. 属性在extension默认是get（只读的），当属性需要在extension中修改时必须用set（可写）修饰，
    var didPrintType : Bool? { get set }
    func doSomething(_ active: String)
    func myName(_ name : String )
}

extension ActiveProtocol {
    // 2. 当前方法将会将会修改它相关联的对象实例的属性值时必须用 mutating 修饰.
    mutating func printType() {
        didPrintType = true
        print("my type is " + type)
    }

    func myName(_ name : String ) {
        print("my name is " + name)
    }
    func doSomething(_ active: String) {
        print("do something " + active)
    }
}

// protocol中可以声明变量，方便在协议方法中使用
// 协议方法的具体实现需要在extension中来实现

struct Studens : ActiveProtocol {
    var didPrintType: Bool?
    
    var type: String
    var name : String
    var id : Int
    init() {
        self.name = "ydd"
        self.id = 0
        self.type = ""
    }
}

struct Programmer : ActiveProtocol {
    var didPrintType: Bool?
    
    var type: String
    var name: String

    init() {
        type = ""
        name = ""
    }
}

var ydd = Studens()
ydd.type = "Studens"
ydd.myName(ydd.name)
ydd.printType()

var programmer = Programmer()
programmer.name = "wyy"
programmer.type = "Programmer"

programmer.myName(programmer.name)
programmer.printType()

if !(programmer.didPrintType ?? false) {
    programmer.printType()
} else {
    print("已经输出过type")
}

// StudentClass约束协议
protocol StudentClassProtocol {
    func goodgoodStudy();
}

class StudentClass : ActiveProtocol, StudentClassProtocol {
    var type: String = ""
    var name: String = ""
    
    var didPrintType: Bool?
    init(type:String, name:String) {
        self.type = type
        self.name = name
    }
    
    func myName(_ name: String) {
        print("我的名字是 : " + name)
    }
}

class WorkClass {
    var delegate:ActiveProtocol?
    
    func workAction(name:String) {
        guard delegate == nil else {
            delegate?.doSomething(name)
            return
        }
    }
}

class WyyClass : StudentClass {
    
}

// 使用 where 为StudentProtocol添加 StudentClass 约束，这样就只有StudentClass 及其子类可以签订StudentProtocol协议，
// 添加约束后，extension可以直接访问约束类的属性和方法
// where不能为struct添加约束
extension StudentClassProtocol where Self : StudentClass {
    func goodgoodStudy() {
        self.doSomething("study")
        print(name + " good goood study day day up!")
    }
}


var wyy = StudentClass.init(type: "Class", name: "wyy")
wyy.myName(wyy.name)
wyy.printType()
wyy.goodgoodStudy()

var work = WorkClass.init()
work.delegate = wyy
work.workAction(name: "eat")

var yddWork = WorkClass.init()
yddWork.delegate = ydd
yddWork.workAction(name: "love wyy")

var wyyObj = WyyClass.init(type: "WyyClass", name: "wyy")

wyyObj.goodgoodStudy()




protocol SayProtocol {
    var say:String { get }
    func sayFrom()
}

extension SayProtocol  {
    func sayFrom() {
        print(say)
    }
}

struct Data : SayProtocol {
    var say: String
}

struct FData : SayProtocol {
    var say: String
}

var data = Data.init(say: "Hello Golang")
var fdata = FData.init(say: "Hello Swift")

data.sayFrom()
fdata.sayFrom()

