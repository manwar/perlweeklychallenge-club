#!/usr/bin/env python3
"""
Challenge 018, Task 2: Priority Queue

Write a script to implement Priority Queue.
It should support:
- is_empty: check whether the queue has no elements
- insert_with_priority: add an element to the queue with an associated priority
- pull_highest_priority_element: remove the element with highest priority

If two elements have the same priority, return element added first.

Author: Lubos Kolouch
"""

import unittest
from typing import Any, Optional


class PriorityQueue:
    """Priority queue implementation using a list (ordered by priority)."""

    def __init__(self):
        """Initialize an empty priority queue."""
        self._queue: list[tuple[int, int, Any]] = []
        self._counter = 0  # For FIFO when priorities are equal

    def is_empty(self) -> bool:
        """
        Check whether the queue has no elements.

        Returns:
            True if queue is empty, False otherwise

        Examples:
            >>> pq = PriorityQueue()
            >>> pq.is_empty()
            True
            >>> pq.insert_with_priority("task", 1)
            >>> pq.is_empty()
            False
        """
        return len(self._queue) == 0

    def insert_with_priority(self, value: Any, priority: int) -> None:
        """
        Add an element to the queue with an associated priority.

        Lower priority number = higher priority (processed first).

        Args:
            value: The element to add
            priority: The priority (lower = more important)

        Examples:
            >>> pq = PriorityQueue()
            >>> pq.insert_with_priority("low priority task", 10)
            >>> pq.insert_with_priority("high priority task", 1)
        """
        # Use counter to maintain insertion order for equal priorities
        # Format: (priority, counter, value)
        entry = (priority, self._counter, value)
        self._counter += 1

        # Insert in sorted position
        inserted = False
        for i, (p, _, _) in enumerate(self._queue):
            if priority < p:  # Higher priority (lower number) goes first
                self._queue.insert(i, entry)
                inserted = True
                break

        if not inserted:
            self._queue.append(entry)

    def pull_highest_priority_element(self) -> Any:
        """
        Remove and return the element with the highest priority.

        Returns:
            The element with highest priority (lowest priority number)

        Raises:
            IndexError: If queue is empty

        Examples:
            >>> pq = PriorityQueue()
            >>> pq.insert_with_priority("task1", 2)
            >>> pq.insert_with_priority("task2", 1)
            >>> pq.pull_highest_priority_element()
            'task2'
        """
        if self.is_empty():
            raise IndexError("Queue is empty")

        _, _, value = self._queue.pop(0)
        return value

    def peek(self) -> Optional[Any]:
        """
        Return the highest priority element without removing it.

        Returns:
            The element with highest priority, or None if empty
        """
        if self.is_empty():
            return None
        return self._queue[0][2]

    def size(self) -> int:
        """
        Return the number of elements in the queue.

        Returns:
            Number of elements
        """
        return len(self._queue)

    def __len__(self) -> int:
        """Return the number of elements."""
        return len(self._queue)

    def __repr__(self) -> str:
        """Return string representation of queue."""
        items = [(p, v) for p, _, v in self._queue]
        return f"PriorityQueue({items})"


def main() -> None:
    """Main function to demonstrate priority queue."""
    pq = PriorityQueue()

    print("Priority Queue Operations:")
    print("-" * 40)

    # Insert some tasks
    tasks = [
        ("send email", 3),
        ("fix critical bug", 1),
        ("write report", 5),
        ("review code", 4),
        ("urgent meeting", 1),
    ]

    for task, priority in tasks:
        pq.insert_with_priority(task, priority)
        print(f"Added: '{task}' with priority {priority}")

    print(f"\nQueue size: {pq.size()}")
    print(f"Is empty: {pq.is_empty()}")
    print("\nQueue contents (highest priority first):")
    print(pq)

    print("\nPulling elements in priority order:")
    while not pq.is_empty():
        element = pq.pull_highest_priority_element()
        print(f"  -> {element}")


if __name__ == "__main__":
    main()


class TestPriorityQueue(unittest.TestCase):
    """Unit tests for Priority Queue."""

    def test_is_empty(self):
        """Test is_empty on new queue."""
        pq = PriorityQueue()
        self.assertTrue(pq.is_empty())

    def test_is_empty_after_insert(self):
        """Test is_empty after insert."""
        pq = PriorityQueue()
        pq.insert_with_priority("task", 1)
        self.assertFalse(pq.is_empty())

    def test_insert_and_pull(self):
        """Test basic insert and pull."""
        pq = PriorityQueue()
        pq.insert_with_priority("task1", 2)
        pq.insert_with_priority("task2", 1)

        self.assertEqual(pq.pull_highest_priority_element(), "task2")
        self.assertEqual(pq.pull_highest_priority_element(), "task1")

    def test_same_priority_order(self):
        """Test FIFO order for same priority."""
        pq = PriorityQueue()
        pq.insert_with_priority("first", 1)
        pq.insert_with_priority("second", 1)
        pq.insert_with_priority("third", 1)

        self.assertEqual(pq.pull_highest_priority_element(), "first")
        self.assertEqual(pq.pull_highest_priority_element(), "second")
        self.assertEqual(pq.pull_highest_priority_element(), "third")

    def test_empty_raises_error(self):
        """Test pulling from empty queue raises error."""
        pq = PriorityQueue()
        with self.assertRaises(IndexError):
            pq.pull_highest_priority_element()

    def test_size(self):
        """Test size method."""
        pq = PriorityQueue()
        self.assertEqual(pq.size(), 0)

        pq.insert_with_priority("a", 1)
        pq.insert_with_priority("b", 2)
        self.assertEqual(pq.size(), 2)

        pq.pull_highest_priority_element()
        self.assertEqual(pq.size(), 1)

    def test_peek(self):
        """Test peek method."""
        pq = PriorityQueue()
        self.assertIsNone(pq.peek())

        pq.insert_with_priority("task", 1)
        self.assertEqual(pq.peek(), "task")

    def test_multiple_priorities(self):
        """Test with various priority levels."""
        pq = PriorityQueue()
        pq.insert_with_priority("low", 10)
        pq.insert_with_priority("high", 1)
        pq.insert_with_priority("medium", 5)

        self.assertEqual(pq.pull_highest_priority_element(), "high")
        self.assertEqual(pq.pull_highest_priority_element(), "medium")
        self.assertEqual(pq.pull_highest_priority_element(), "low")

    def test_len(self):
        """Test len() method."""
        pq = PriorityQueue()
        self.assertEqual(len(pq), 0)

        pq.insert_with_priority("a", 1)
        self.assertEqual(len(pq), 1)

    def test_repr(self):
        """Test string representation."""
        pq = PriorityQueue()
        pq.insert_with_priority("task", 1)
        self.assertIn("task", repr(pq))


if __name__ == "__main__":
    unittest.main()
