//: Playground - noun: a place where people can play

// Sample for Codable protocol.
// https://dev.classmethod.jp/smartphone/json-decoding-without-swiftyjson/
// https://qiita.com/Mt-Hodaka/items/d14447a429948a3fb28c

import UIKit

struct User: Codable {
    let name: String
    let age: Int
    let message: String?
}

// 基本形（全てのデータあり）
let jsonStr = """
{
    "name" : "Munesada",
    "age" : 32,
    "message" : "Hello"
}
"""
let jsonData = jsonStr.data(using: .utf8)
let user = try! JSONDecoder().decode(User.self, from: jsonData!)
print("name: \(user.name)")
print("age: \(user.age)")
print("message: \(user.message ?? "No message.")")

// 基本形（オプショナルはない場合）
let jsonStr2 = """
{
    "name" : "Munesada",
    "age" : 32
}
"""
let jsonData2 = jsonStr2.data(using: .utf8)
let user2 = try! JSONDecoder().decode(User.self, from: jsonData2!)
print("name: \(user2.name)")
print("age: \(user2.age)")
print("message: \(user2.message ?? "No message.")")

// 入れ子もできる.
struct Group: Codable {
    let groupName: String
    let users: [User]
}
let jsonStr3 = """
{
    "groupName": "グループ名",
    "users" : [{
        "name" : "Munesada",
        "age" : 32
    }, {
        "name" : "Yamada",
        "age" : 28
    }]
}
"""
let jsonData3 = jsonStr3.data(using: .utf8)
let group = try! JSONDecoder().decode(Group.self, from: jsonData3!)
print("groupName: \(group.groupName)")
print("users: \(group.users)")

// ルートがArrayの場合
let jsonStr4 = """
[
{ "name" : "Yohei", "age" : 32 },
{ "name" : "Kengo", "age" : 42 }
]
"""
let jsonData4 = jsonStr4.data(using: .utf8)
let users = try! JSONDecoder().decode([User].self, from: jsonData4!)
print("users: \(users)")

// Date型のパース
struct MyDate: Codable {
    let dt: Date
}
let jsonStr5 = """
{ "dt" : "2018-03-03T12:13:31Z" }
"""
let jsonData5 = jsonStr5.data(using: .utf8)
let decoder1 = JSONDecoder()
decoder1.dateDecodingStrategy = .iso8601
let myDate = try! decoder1.decode(MyDate.self, from: jsonData5!)
print("myDate: \(myDate)")

// JSON文字列の生成
let user3 = User(name: "Yohei", age: 20, message: "Hi")
let user4 = User(name: "Sasuke", age: 40, message: "Sleepy")
let group1 = Group(groupName: "Stock Group", users: [ user3, user4 ])
let data = try! JSONEncoder().encode(group1)
let jsonString = String(data: data, encoding: .utf8)
print("jsonString: \(jsonString ?? "")")























