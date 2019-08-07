import UIKit

var str = "Hello, playground"

// 多行字符串使用三个双引号
var lineStr = """
"醉卧沙场君莫笑，
古来征战几人回."
"""

lineStr = """
\"""醉卧沙场君莫笑，
古来征战几人回."
"""

lineStr = "\"醉卧沙场君莫笑,古来征战几人回.\""

// 空字符串
var empyStr = ""
empyStr.isEmpty
empyStr = String()
empyStr.isEmpty

var fristStr = "醉卧沙场君莫笑,"
var secondStr = "古来征战几人回."
// 拼接字符串
var newStr = fristStr + secondStr
fristStr.append(secondStr)

var targetStr = "醉卧沙场君莫笑,古来征战几人回."
// 取出第一个，类型为Character
let fristChar = targetStr[targetStr.startIndex]
// 获取最后一个字符（最后位置前面的字符）
let lastChar = targetStr[targetStr.index(before: targetStr.endIndex)]
// 获取第二个字符（第一个字符后面的字符）
let secondChar = targetStr[targetStr.index(after: targetStr.startIndex)]
// 获取第7个字符的索引（Index）
let index = targetStr.index(targetStr.startIndex, offsetBy: 7)
// 通过索引号获取字符
let subChar = targetStr[index]
// 遍历字符
for index in targetStr.indices {
    print("target Cjaracter \(targetStr[index])")
}

// 将Character转为String
var frist = String(describing: fristChar)
let last = String(describing: lastChar)
frist.append(last)

let anchor = "  ___辛弃疾"
// 插入单个字符
targetStr.insert("_", at: targetStr.endIndex)
// 插入多个字符
targetStr.insert(contentsOf: anchor, at: targetStr.endIndex)
// 删除一个字符
var indexPath = -(anchor.count + 1)
targetStr.remove(at: targetStr.index(targetStr.endIndex, offsetBy: indexPath))
indexPath += 1
let subStr = targetStr
// 截取字符串
let range = targetStr.index(targetStr.endIndex, offsetBy: indexPath)..<targetStr.endIndex
targetStr.removeSubrange(range)

// 获取字符的位置
let wordRange = targetStr.range(of: ",")
// 截取”，“前面的字符（不包含”，“）
let prefix = targetStr.prefix(upTo: wordRange!.lowerBound)
// 截取","后面的字符（不包含”，“）
let suffix = targetStr.suffix(from: wordRange!.upperBound)


//截取”，“前字符(包含”，“)
let prefixHas = targetStr.prefix(upTo: wordRange!.upperBound)
//截取”，“后字符(包含”，“)
let suffixHas = targetStr.suffix(from: wordRange!.lowerBound)


//3.2.7 字符串和字符相等使用“等于”运算符 ( ==) 和“不等”运算符 ( !=)进行检查：

let quotation428 = "We're a lot alike, you and I."
let sameQuotatio = "We're a lot alike, you and I."
if quotation428 == sameQuotatio {
    print("These two string are considered equal")
}
//前缀,后缀相等用 hasPrefix 和 hasSuffix
if sameQuotatio.hasPrefix("We're"){
    print("head has We're")
}
if sameQuotatio.hasSuffix("."){
    print("last word is \".\"")
}
//3.2.8字符串常用的截取n到n+m位置的字符串
var testStr = "abcdeflovewhrdsdada"
let index1 = testStr.index(testStr.startIndex, offsetBy: 6)
let index2 = testStr.index(testStr.startIndex, offsetBy: 13)
let result = testStr[index1 ..< index2] //lovewhr
//3.2.9 截取两个特定字符之间的字符串
do {
    let testStr = "abcdef&lovewhr*dsdada"
    let index1 = testStr.index(after: testStr.firstIndex(of: "&")!)
    let index2 = testStr.firstIndex(of: "*")
    let result = testStr[index1 ..< index2!]
    print("result : \(result)")
}

    
//    ---------------------
//作者：ios攻城狮0305
//来源：CSDN
//原文：https://blog.csdn.net/qq_35122556/article/details/80184046
//版权声明：本文为博主原创文章，转载请附上博文链接！
