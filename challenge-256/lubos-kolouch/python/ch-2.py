def merge_strings(str1: str, str2: str) -> str:
    merged = "".join(a + b for a, b in zip(str1, str2))
    longer_part = str1[len(str2) :] if len(str1) > len(str2) else str2[len(str1) :]
    return merged + longer_part


# Tests
assert merge_strings("abcd", "1234") == "a1b2c3d4"
assert merge_strings("abc", "12345") == "a1b2c345"
assert merge_strings("abcde", "123") == "a1b2c3de"
