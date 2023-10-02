#!/usr/bin/env python
# -*- coding: utf-8 -*-

class LinkedList:
    def __init__(self, value=0, next=None):
        self.value = value
        self.next = next

    def add(self, other):
        carry = 0
        head = tail = LinkedList()
        while self or other or carry:
            sum = (self.value if self else 0) + \
                (other.value if other else 0) + carry
            tail.next = LinkedList(sum % 10)
            tail = tail.next
            carry = sum // 10
            self = self.next if self else None
            other = other.next if other else None
        return head.next

    def __str__(self):
        node = self
        values = []
        while node:
            values.append(str(node.value))
            node = node.next
        return ' -> '.join(values)


l1 = LinkedList(1, LinkedList(2, LinkedList(3)))
l2 = LinkedList(3, LinkedList(2, LinkedList(1)))

result = l1.add(l2)
print(result)
