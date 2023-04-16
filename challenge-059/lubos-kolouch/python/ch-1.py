#!/usr/bin/env python
# -*- coding: utf-8 -*-

class LinkedList:
    def __init__(self, value):
        self.value = value
        self.next = None

    def append(self, value):
        current = self
        while current.next:
            current = current.next
        current.next = LinkedList(value)

    def partition(self, k):
        less_head = None
        greater_head = None
        less_tail = None
        greater_tail = None

        current = self
        while current:
            if current.value < k:
                if less_tail:
                    less_tail.next = current
                else:
                    less_head = current
                less_tail = current
            else:
                if greater_tail:
                    greater_tail.next = current
                else:
                    greater_head = current
                greater_tail = current
            current = current.next

        if less_tail:
            less_tail.next = greater_head
        else:
            less_head = greater_head

        if greater_tail:
            greater_tail.next = None

        return less_head

    def __str__(self):
        current = self
        result = []
        while current:
            result.append(str(current.value) + " → ")
            current = current.next
        result.append("END")
        return "".join(result)


if __name__ == "__main__":
    linked_list = LinkedList(1)
    linked_list.append(4)
    linked_list.append(3)
    linked_list.append(2)
    linked_list.append(5)
    linked_list.append(2)

    print("Original list:", linked_list)
    k_val = 3
    partitioned_list = linked_list.partition(k_val)
    print(f"Partitioned list with k={k_val}:", partitioned_list)
       
