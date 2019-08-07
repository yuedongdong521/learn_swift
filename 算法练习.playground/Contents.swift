import UIKit

var str = "Hello, playground"

var targetArr: Array<Int> = Array()

for _ in 1...10 {
    targetArr.append(Int(arc4random() % 10))
}
print("target Array : \(targetArr)")

//

 do {
     var array = targetArr
     var count = 0
    
     for i in 0..<array.count {
         for j in i+1..<array.count {
             let tmp:Int
             if array[i] > array[j] {
             tmp = array[i]
             array[i] = array[j]
             array[j] = tmp
            }
            count += 1
        }
    }
 print("array = \(array) , count = \(count)")
 }

 // 冒泡排序优化
 do {
     var array = targetArr
     var count = 0
     var flag = array.count
     while flag > 0 {
         let total = flag
         flag = 0
         for i in 1..<total {
             var tmp:Int
             if array[i - 1] > array[i] {
                 tmp = array[i - 1]
                 array[i - 1] = array[i]
                 array[i] = tmp
                 flag = i
             }
             count += 1
         }
     }
     print("array = \(array) , count = \(count)")
 
 }


// 二分法取a在升序数组中的位置
do {
//    var array = targetArr.sorted()
    var array = targetArr.sorted { (a, b) -> Bool in
        a < b
    }
    let count = array.count
    var a = array[9]
    print("array = \(array), a = \(a)")
    
    func getIndex(array:Array<Int>, a:Int) -> Int {
        let count = array.count
        var mideIndex = count / 2
        var num = 0
    
        while num < count {
            let value = array[mideIndex]
            num += 1
             print("mideIndex : \(mideIndex)")
            if value == a {
                print("num = \(num)")
                return mideIndex
            } else if value > a {
                mideIndex = mideIndex / 2
            } else {
                mideIndex = (mideIndex + count) / 2
            }
        }
       
        return -1
    }
    
    let index = getIndex(array: array, a: a)
    
    print("index : \(index)")
}


// 二分法取a在降序数组中的位置
do {
    //    var array = targetArr.sorted()
    var array = targetArr.sorted { (a, b) -> Bool in
        a > b
    }
    let count = array.count
    var a = array[9]
    print("array = \(array), a = \(a)")
    
    func getIndex(array:Array<Int>, a:Int) -> Int {
        let count = array.count
        var mideIndex = count / 2
        var num = 0
        
        while num < count {
            let value = array[mideIndex]
            num += 1
            print("mideIndex : \(mideIndex)")
            if value == a {
                print("num = \(num)")
                return mideIndex
            } else if value > a {
                mideIndex = (mideIndex + count) / 2
            } else {
                mideIndex = mideIndex / 2
            }
        }
        
        return -1
    }
    
    let index = getIndex(array: array, a: a)
    
    print("index : \(index)")
}


// 1/2gt^2
do {
    func move(a:Float, t:Int) -> Float {
        return 0.5 * a * Float(t * t)
    }
    
    for t in 0...20 {
        let y = move(a: 9.8, t: t)
    }
}

do {
    let r : Float = 16
    var x : Float
    var y : Float
    let n : Float = 2
//    pow(r, n) = pow(x, n) + pow(y, n)
    
    
    
    for index in -16...16 {
        x = sqrt(pow(r, n) - pow(Float(index), n))
        x = -x
    }
}


do {
    var array:Array<String> = Array()
    
    for index in 0..<targetArr.count {
        array.append(String(targetArr[index]))
    }
    
    let strArr = array.sorted()
    let arr = array.sorted { (a, b) -> Bool in
        a > b
    }
    print("array = \(array) \nStrArr = \(strArr) \narr = \(arr)")
    
}



