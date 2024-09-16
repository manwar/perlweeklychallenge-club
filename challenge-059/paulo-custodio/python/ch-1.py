#!/usr/bin/env python3

# Challenge 059
#
# TASK #1 › Linked List
# Reviewed by Ryan Thompson
# You are given a linked list and a value k. Write a script to partition the
# linked list such that all nodes less than k come before nodes greater than or
# equal to k. Make sure you preserve the original relative order of the nodes in
# each of the two partitions.
#
# For example:
#
# Linked List: 1 -> 4 -> 3 -> 2 -> 5 -> 2
#
# k = 3
#
# Expected Output: 1 -> 2 -> 2 -> 4 -> 3 -> 5.

import sys

class Node:
    def __init__(self, data):
        self.data = data
        self.next = None

    def __str__(self):
        out = "["+str(self.data)
        if self.next:
            return out+","+str(self.next)+"]"
        else:
            return out+"]"

class LinkedList:
    def __init__(self):
        self.head = None

    def __str__(self):
        out = ""
        current = self.head
        while current:
            out += str(current.data)+" -> "
            current = current.next
        out += "None"
        return out

    def push_front(self, data):
        new_node = Node(data)
        new_node.next = self.head
        self.head = new_node

    def push_back(self, data):
        new_node = Node(data)
        if not self.head:
            self.head = new_node
        else:
            last_node = self.head
            while last_node.next:
                last_node = last_node.next
            last_node.next = new_node

    def insert_at(self, index, data):
        if index == 0:
            self.push_front(data)
        else:
            new_node = Node(data)
            current = self.head
            for _ in range(index - 1):
                if not current:
                    raise IndexError("Index out of bounds")
                current = current.next
            new_node.next = current.next
            current.next = new_node

    def remove_node(self, key):
        current = self.head
        if current and current.data == key:
            self.head = current.next
            current = None
        else:
            prev = None
            while current and current.data != key:
                prev = current
                current = current.next
            if current:
                prev.next = current.next
                current = None

def partition(list, k):
    below = LinkedList()
    above = LinkedList()

    p = list.head
    while p:
        if p.data < k:
            below.push_back(p.data)
        else:
            above.push_back(p.data)
        p = p.next

    list = below
    p = above.head
    while p:
        list.push_back(p.data)
        p = p.next

    return list

k = int(sys.argv[1])
list = LinkedList()
for x in sys.argv[2:]:
    list.push_back(int(x))
list = partition(list, k)
print(list)
