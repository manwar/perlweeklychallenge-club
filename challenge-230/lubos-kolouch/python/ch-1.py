from typing import List, Iterable


def separate_digits(ints: Iterable[int]) -> List[int]:
    """Separate ints into individual digits"""
    return list(map(int, filter(str.isdigit, "".join(map(str, ints)))))


def test_separate_digits():
    assert separate_digits([1, 34, 5, 6]) == [1, 3, 4, 5, 6]
    assert separate_digits([1, 24, 51, 60]) == [1, 2, 4, 5, 1, 6, 0]


if __name__ == "__main__":
    test_separate_digits()
