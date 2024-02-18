from typing import List


def max_pairs(words: list[str]) -> int:
    word_set = set(words)
    count = sum(1 for word in words if word[::-1] in word_set)
    return count // 2


# Tests
assert max_pairs(["ab", "de", "ed", "bc"]) == 1
assert max_pairs(["aa", "ba", "cd", "ed"]) == 0
assert max_pairs(["uv", "qp", "st", "vu", "mn", "pq"]) == 2
