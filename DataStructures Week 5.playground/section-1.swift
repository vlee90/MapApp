// Playground - noun: a place where people can play

import UIKit


//Linked List

class Node <A> {
    var value: A
    var nextNode: Node?
    init(value: A) {
        self.value = value
    }
}

class LinkedList <A> {
    var head: Node <A>?
    
    func addNode(newNode: Node <A>) {
        // If the head exists...
        if self.head != nil {
            var currentNode = self.head
            // While the currentNode is not the last node...
            while currentNode?.nextNode != nil {
                currentNode = currentNode?.nextNode
            }
            currentNode?.nextNode = newNode
        }
        else {
            self.head = newNode
        }
    }
    
    func deleteNode() {
        if self.head?.nextNode != nil {
            var currentNode = self.head
            while currentNode?.nextNode != nil {
                currentNode = currentNode?.nextNode
            }
            currentNode = nil
        }
    }
}

//var Vincent = Node(value: "Vincent")
//var Shawn = Node(value: "Shawn")
//var Jennifer = Node(value: "Jennifer")
//
//Vincent.nextNode = Shawn
//Shawn.nextNode = Jennifer
//
//var list: LinkedList <String> = LinkedList()
//
//list.head = Vincent
//
//
//println(list.head!.value)
//println(list.head!.nextNode!.value)
//println(list.head!.nextNode!.nextNode!.value)
//
//var Kevin = Node(value: "Kevin")
//list.addNode(Kevin)
//println(list.head!.nextNode!.nextNode!.nextNode!.value)
//
//list.deleteNode()
//println(list.head!.value)
//println(list.head!.nextNode!.value)
//println(list.head!.nextNode!.nextNode!.value)
//println(list.head!.nextNode!.nextNode!.nextNode!.value)

class queue {
    
}

