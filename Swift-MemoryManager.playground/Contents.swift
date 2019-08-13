import UIKit

var str = "Hello, playground"

class User {
    var name:String = ""
    
    var chanageName:((_ name:String) -> String)?
    
     var phone:Phone?
    
    init(name:String) {
        self.name = name
        print("user \(name) init")
    }
    
    deinit {
        print("user \(self.name) deinit")
    }
}


class Phone {
    var type: String
    weak var owrn: User?
    init(type:String) {
        self.type = type
        print("phone \(self.type) init")
    }
    
    deinit {
        print("phone \(self.type) deinit")
    }
}

do {
    let ydd: User = User(name: "ydd")
    weak var weakydd = ydd
    ydd.chanageName = { name in
        return (weakydd?.name ?? "") + "wyy"
    }
    
    let iphone = Phone(type: "iPhone")
    iphone.owrn = ydd
    ydd.phone = iphone
    
 
}

