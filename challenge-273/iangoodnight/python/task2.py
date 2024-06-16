"""
## Task 2: B After A

**Submitted by:** [Mohammad Sajid Anwar][0]

You are given a string, `$str`.

Write a script to return `true` if there is at least one `b`, and no `a`
appears after the first `b`.

**Example 1**

```
Input: $str = "aabb"
Output: true
```

**Example 2**

```
Input: $str = "abab"
Output: false
```

**Example 3**

```
Input: $str = "aaa"
Output: false
```

**Example 4**

```
Input: $str = "bbb"
Output: true
```

[0]: https://manwar.org/
"""


def b_after_a(string: str) -> bool:
    """
    Returns `true` if there is at least one `b`, and no `a` appears after the
    first `b`.

    Args:
        string: The input string to check for the presence of `b` and `a`.

    Returns:
        `True` if there is at least one `b`, and no `a` appears after the first
        `b`; otherwise, `False`.
    """
    if "b" not in string:  # fails if there is no `b` in the string
        return False
    b_index = string.index("b")
    # grab a slice of the string after the first `b`
    sliced_after_b = string[b_index + 1:]
    # check if there is no `a` in the slice
    return "a" not in sliced_after_b
