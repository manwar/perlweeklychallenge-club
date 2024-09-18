import unittest


def strong_password_steps(s: str) -> int:
    """
    Calculates the minimum number of steps required to make the given string a strong password.

    A strong password must:
    - Be at least 6 characters long.
    - Contain at least one lowercase letter, one uppercase letter, and one digit.
    - Not contain three repeating characters in a row.

    Args:
        s (str): The input password string.

    Returns:
        int: The minimum number of steps required to make the password strong.
    """
    import re
    missing_types = 3
    if re.search(r'[a-z]', s):
        missing_types -= 1
    if re.search(r'[A-Z]', s):
        missing_types -= 1
    if re.search(r'\d', s):
        missing_types -= 1

    repeats_to_fix = 0
    i = 2
    n = len(s)
    while i < n:
        if s[i] == s[i - 1] == s[i - 2]:
            repeat_len = 3
            while i + 1 < n and s[i + 1] == s[i]:
                repeat_len += 1
                i += 1
            repeats_to_fix += repeat_len // 3
        i += 1

    if n >= 6:
        total_steps = max(missing_types, repeats_to_fix)
    else:
        total_steps = max(missing_types + repeats_to_fix, 6 - n)
    return total_steps


# Unit Tests
class TestStrongPassword(unittest.TestCase):

    def test_examples(self):
        self.assertEqual(strong_password_steps("a"), 5, 'Example 1')
        self.assertEqual(strong_password_steps("aB2"), 3, 'Example 2')
        self.assertEqual(strong_password_steps("PaaSW0rd"), 0, 'Example 3')
        self.assertEqual(strong_password_steps("Paaasw0rd"), 1, 'Example 4')
        self.assertEqual(strong_password_steps("aaaaa"), 3, 'Example 5')


if __name__ == "__main__":
    unittest.main()
