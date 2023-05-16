#!/usr/bin/env python
# -*- coding: utf-8 -*-

class Node:
    def __init__(self, x):
        self.val = x
        self.next = None


def reorderList(head):
    # Find the middle of the linked list
    slow = fast = head
    while fast and fast.next:
        slow = slow.next
        fast = fast.next.next

    # Reverse the second half of the linked list
    prev = None
    while slow:
        next_node = slow.next
        slow.next = prev
        prev = slow
        slow = next_node

    # Merge the first half and the reversed second half
    first_half = head
    second_half = prev
    while second_half.next:
        first_half.next, first_half = second_half, first_half.next
        second_half.next, second_half = first_half, second_half.next

    return head


# Test the function
head = Node(1)
head.next = Node(2)
head.next.next = Node(3)
head.next.next.next = Node(4)
reordered_list = reorderList(head)

node = reordered_list
while node:
    print(node.val, end=" ")
    node = node.next
