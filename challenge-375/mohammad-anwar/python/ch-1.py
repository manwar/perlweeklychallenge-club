#!/usr/bin/env python3

def count_unique_common(array1, array2):
    freq1 = {}
    freq2 = {}

    for item in array1:
        freq1[item] = freq1.get(item, 0) + 1

    for item in array2:
        freq2[item] = freq2.get(item, 0) + 1

    return sum(1 for item in freq1
               if freq1[item] == 1
               and item in freq2
               and freq2[item] == 1)

def test():
    examples = [
        (["apple", "banana", "cherry"], ["banana", "cherry", "date"], 2),
        (["a", "ab", "abc"], ["a", "a", "ab", "abc"], 2),
        (["orange", "lemon"], ["grape", "melon"], 0),
        (["test", "test", "demo"], ["test", "demo", "demo"], 0),
        (["Hello", "world"], ["hello", "world"], 1),
    ]

    for array1, array2, expected in examples:
        result = count_unique_common(array1, array2)
        assert result == expected, f"Failed: expected {expected}, got {result}"

    print("\nAll tests passed!")

if __name__ == "__main__":
    test()
