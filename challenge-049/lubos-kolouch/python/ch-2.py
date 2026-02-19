#!/usr/bin/env python3
"""
Perl Weekly Challenge 049 - Task 2: LRU Cache

Demonstrate an LRU cache with operations:
- set(key, value)
- get(key) -> value or -1 if missing

The embedded test follows the example from the challenge spec.
"""

from __future__ import annotations

from collections import OrderedDict
from typing import Generic, MutableMapping, Optional, Sequence, TypeVar

K = TypeVar("K")
V = TypeVar("V")


class LRUCache(Generic[K, V]):
    def __init__(self, capacity: int) -> None:
        if capacity <= 0:
            raise ValueError("capacity must be positive")
        self._capacity = capacity
        self._data: "OrderedDict[K, V]" = OrderedDict()

    def get(self, key: K) -> Optional[V]:
        if key not in self._data:
            return None
        self._data.move_to_end(key)
        return self._data[key]

    def set(self, key: K, value: V) -> None:
        if key in self._data:
            self._data.move_to_end(key)
        self._data[key] = value
        if len(self._data) > self._capacity:
            self._data.popitem(last=False)

    def as_keys_lru_to_mru(self) -> Sequence[K]:
        return list(self._data.keys())


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    raise SystemExit("Run without arguments to execute the embedded tests.")


def _run_tests() -> None:
    import unittest

    class TestChallenge049Task2(unittest.TestCase):
        def test_spec_example(self) -> None:
            cache: LRUCache[int, int] = LRUCache(capacity=3)
            cache.set(1, 3)
            cache.set(2, 5)
            cache.set(3, 7)

            self.assertEqual(cache.as_keys_lru_to_mru(), [1, 2, 3])
            self.assertEqual(cache.get(2), 5)
            self.assertEqual(cache.as_keys_lru_to_mru(), [1, 3, 2])
            self.assertEqual(cache.get(1), 3)
            self.assertEqual(cache.as_keys_lru_to_mru(), [3, 2, 1])
            self.assertIsNone(cache.get(4))

            cache.set(4, 9)
            self.assertEqual(cache.as_keys_lru_to_mru(), [2, 1, 4])
            self.assertIsNone(cache.get(3))

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge049Task2)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

