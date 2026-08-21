#!/usr/bin/env python3
"""
Perl Weekly Challenge 071 - Task 2: Trim Linked List

You are given a linked list and a positive integer $N.
Write a script to remove the $Nth element from the end of the list
and print the linked list.
"""

from __future__ import annotations
from typing import Any
import unittest


class Node:
    """A single node in a singly-linked list."""

    def __init__(self, data: Any = None, next_node: Node | None = None) -> None:
        self.data: Any = data
        self.next: Node | None = next_node


class LinkedList:
    """A singly-linked list supporting appending and trimming from the end."""

    def __init__(self) -> None:
        self.head: Node | None = None

    def append(self, data: Any) -> None:
        """Append an element to the end of the list."""
        new_node = Node(data)
        if not self.head:
            self.head = new_node
            return
        cur = self.head
        while cur.next:
            cur = cur.next
        cur.next = new_node

    def remove_from_end(self, n: int) -> None:
        """Remove the n-th element from the end of the list (1-indexed)."""
        if self.head is None or n <= 0:
            return

        size = 0
        cur: Node | None = self.head
        while cur:
            size += 1
            cur = cur.next

        if n >= size:
            self.head = self.head.next
        else:
            cur = self.head
            for _ in range(size - n - 1):
                if cur is not None:
                    cur = cur.next
            if cur is not None and cur.next is not None:
                cur.next = cur.next.next

    def to_list(self) -> list[Any]:
        """Convert the linked list values to a Python list."""
        values: list[Any] = []
        cur = self.head
        while cur:
            values.append(cur.data)
            cur = cur.next
        return values

    def __str__(self) -> str:
        return " -> ".join(map(str, self.to_list()))


class TestTrimLinkedList(unittest.TestCase):
    def test_remove_last_element(self) -> None:
        ll = LinkedList()
        for i in range(1, 6):
            ll.append(i)
        ll.remove_from_end(1)
        self.assertEqual(ll.to_list(), [1, 2, 3, 4])

    def test_remove_second_from_end(self) -> None:
        ll = LinkedList()
        for i in range(1, 6):
            ll.append(i)
        ll.remove_from_end(2)
        self.assertEqual(ll.to_list(), [1, 2, 3, 5])

    def test_remove_head(self) -> None:
        ll = LinkedList()
        for i in range(1, 6):
            ll.append(i)
        ll.remove_from_end(5)
        self.assertEqual(ll.to_list(), [2, 3, 4, 5])

    def test_remove_exceeding_length(self) -> None:
        ll = LinkedList()
        for i in range(1, 6):
            ll.append(i)
        ll.remove_from_end(10)
        self.assertEqual(ll.to_list(), [2, 3, 4, 5])


if __name__ == "__main__":
    unittest.main()
