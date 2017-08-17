//: Playground - noun: a place where people can play

import UIKit

// https://www.hackerrank.com/challenges/ctci-contacts/problem

class TrieNode<T: Hashable> {
    var value: T?
    weak var parent: TrieNode<T>?
    var children: [T: TrieNode] = [:]
    var count: Int = 0

    init(value: T? = nil, parentNode: TrieNode? = nil) {
        self.value = value
        self.parent = parentNode
    }
    
    func add(value: T) {
        guard children[value] == nil else {
            return
        }
        children[value] = TrieNode(value: value, parentNode: self)
    }
}

class Trie {
    typealias Node = TrieNode<Character>
    let root: Node = Node()
    var depth = 0
    
    var searchedItems = [String: Node]()
    
    func insert(word: String) {
        guard !word.isEmpty else {
            return
        }
        var currentNode = root
        var tempDepth = 0
        for character in word.characters {
            if let childNode = currentNode.children[character] {
                currentNode = childNode
            } else {
                currentNode.add(value: character)
                currentNode = currentNode.children[character]!
            }
            tempDepth += 1
            currentNode.count += 1
        }
        
        depth = tempDepth > depth ? tempDepth : depth
    }
    
    func contains(word: String) -> Int {
        
        if word.characters.count > depth {
            return 0
        }
        
        guard !word.isEmpty else {
            return 0
        }
        
        var currentNode = root
        
        print(word)
        print(searchedItems)
        
        for (key, value) in searchedItems {
        
            if key.hasPrefix(word) {
//                currentNode = value
//                
//                print(currentNode.parent.)
            }

        }

        
        for character in word.characters {
            guard let childNode = currentNode.children[character] else {
                return 0
            }
            currentNode = childNode
        }
        
        if let _ = currentNode.value {
            searchedItems[word] = currentNode
        }
        return currentNode.count
    }
}


var trie = Trie()

//let a = ["add a", "add ab", "add abc", "find abc", "find a", "find b"]
//let a = ["add abc", "add abd", "find abc"]
let a = ["add abc", "add abd", "find abc", "find ab"]

let n = a.count

var foundString = [String: Int]()
var notFoundString = [String: Int]()

for i in 0..<n {
    var str = a[i]
    if str.range(of:"add ") != nil {
        str.characters.removeFirst(4)
        trie.insert(word: str)
    }
    if str.range(of:"find ") != nil {
        str.characters.removeFirst(5)
        print(trie.contains(word: str))
    }
}

