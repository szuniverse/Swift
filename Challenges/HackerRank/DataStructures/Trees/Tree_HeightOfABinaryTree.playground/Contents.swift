//: Playground - noun: a place where people can play

import UIKit

func getHeight(root: Node?) -> Int {
    guard let root = root else { return 0}
    if (root.left == nil && root.right == nil) {
        return 0
    } else {
        return 1 + max(getHeight(root: root.left), getHeight(root: root.right))
    }
}