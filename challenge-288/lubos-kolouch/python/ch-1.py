import unittest


def closest_palindrome(n_str: str) -> str:
    """
    Finds the closest palindrome to the given integer string, excluding itself.
    If multiple palindromes have the same minimal absolute difference, returns the smallest one.

    Args:
        n_str (str): The input integer as a string.

    Returns:
        str: The closest palindrome integer as a string.
    """
    n = int(n_str)
    length = len(n_str)
    is_even = length % 2 == 0
    mid = length // 2
    left_len = mid if is_even else mid + 1
    left = n_str[:left_len]
    candidates = set()

    for diff in (-1, 0, 1):
        new_left = str(int(left) + diff)
        if len(new_left) != left_len and diff != 0:
            continue
        if is_even:
            pal = new_left + new_left[::-1]
        else:
            pal = new_left + new_left[:-1][::-1]
        candidates.add(pal)

    # Edge cases
    candidates.add("9" * (length - 1))
    candidates.add("1" + ("0" * (length - 1)) + "1")

    candidates.discard(n_str)

    min_diff = None
    closest_pal = ""
    for cand in candidates:
        if cand == "":
            continue
        diff = abs(int(cand) - n)
        if diff == 0:
            continue
        if (
            min_diff is None
            or diff < min_diff
            or (diff == min_diff and int(cand) < int(closest_pal))
        ):
            min_diff = diff
            closest_pal = cand

    return closest_pal


# Unit Tests
class TestClosestPalindrome(unittest.TestCase):
    def test_example1(self):
        self.assertEqual(closest_palindrome("123"), "121", "Example 1")

    def test_example2(self):
        self.assertEqual(closest_palindrome("2"), "1", "Example 2")

    def test_example3(self):
        self.assertEqual(closest_palindrome("1400"), "1441", "Example 3")

    def test_example4(self):
        self.assertEqual(closest_palindrome("1001"), "999", "Example 4")

    def test_large_number(self):
        self.assertEqual(closest_palindrome("999"), "1001", "Large Number")

    def test_all_nines(self):
        self.assertEqual(closest_palindrome("9999"), "10001", "All Nines")


if __name__ == "__main__":
    unittest.main()
