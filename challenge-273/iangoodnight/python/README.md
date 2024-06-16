# Perl Weekly Challenge - 273

Welcome to [Week #273][0] of [The Weekly Challenge][1].

## Task 1: Percentage of Character

**Submitted by:** [Mohammad Sajid Anwar][2]

You are given a string, `$str` and a character `$char`.

Write a script to return the percentage, nearest whole, of given character in
the given string.

**Example 1**

```
Input: $str = "perl", $char = "e"
Output: 25
```

**Example 2**

```
Input: $str = "java", $char = "a"
Output: 50
```

**Example 3**

```
Input: $str = "python", $char = "m"
Output: 0
```

**Example 4**

```
Input: $str = "ada", $char = "a"
Output: 67
```

**Example 5**

```
Input: $str = "ballerina", $char = "l"
Output: 22
```

**Example 6**

```
Input: $str = "analitik", $char = "k"
Output: 13
```

### Solution

### Testing

Our [solution][3] is intentionally designed to be simple and easy to understand.
We have defined two constants, `PERCENTAGE_FACTOR` and `ROUNDING_THRESHOLD`, to
help with the calculation of the percentage. The `percentage_of_character`
function takes two arguments, `string` and `char`, and returns the percentage of
the character in the string, rounded to the nearest whole number.  Using a
declarative approach, we first calculate the length of the string and the number
of times the character appears in the string. We then calculate the percentage
of the character in the string as a decimal, convert it to a percentage, and
round it to the nearest whole number using half up rounding.  It came as a
surprise to find that python implements an `even up` rounding by default, which
could lead to incorrect results. With an `even up` rounding strategy, a value of
`0.5` would be rounded down to `0`, whereas we want it to be rounded up to `1`.
The rounding method we have used is known as `half up` rounding, which rounds
`0.5` up to `1`.  The function returns `0` if the string or character are empty.

```python
PERCENTAGE_FACTOR = 100   # multiply the decimal value by 100 to get percentage
ROUNDING_THRESHOLD = 0.5  # ensure we are rounding half up, rather than even up


def percentage_of_character(string: str, char: str) -> int:
    """Return the percentage of given character in the given string.

    Args:
        string: The string to search for the character.
        char: The character to search for in the string.

    Returns:
        The percentage of the character in the string, rounded to the nearest
        whole number.
    """
    # Get the length of the string for testing and calculating the percentage
    string_length = len(string)
    # Return 0 if the string or character are empty
    if string_length == 0 or len(char) == 0:
        return 0
    # Count the number of times the character appears in the string
    char_count = string.count(char)
    # Calculate the percentage of the character in the string as a decimal
    decimal_percentage = char_count / string_length
    # Convert the decimal percentage to a percentage
    percentage = decimal_percentage * PERCENTAGE_FACTOR
    # Round the percentage to the nearest whole number (half up rounding)
    rounded_percentage = int(percentage + ROUNDING_THRESHOLD)

    return rounded_percentage
```

### Testing

We have written a comprehensive test suite to validate our solution. We have
covered both the base and extra test cases to ensure our solution works as
expected. Runnning the test suite requires the `pytest` module, which can be
installed using `pip install pytest`.

```python
from challenge273.task1 import percentage_of_character


def test_examples() -> None:
    """Test if function returns correct percentage of character"""
    assert percentage_of_character("perl", "e") == 25
    assert percentage_of_character("java", "a") == 50
    assert percentage_of_character("python", "m") == 0
    assert percentage_of_character("ada", "a") == 67
    assert percentage_of_character("ballerina", "l") == 22
    assert percentage_of_character("analitik", "k") == 13


def test_empty_string() -> None:
    """Test if function returns 0 for empty string"""
    assert percentage_of_character("", "a") == 0


def test_empty_character() -> None:
    """Test if function returns 0 for empty character"""
    assert percentage_of_character("python", "") == 0
```

The test suite can be run using the following command:

```bash
$ pytest test_task1.py
```

## Task 2: B After A

**Submitted by:** [Mohammad Sajid Anwar][2]

You are given a string, `$str`.

Write a script to return `true` if there is at least one `b`, and no `a` appears
after the first `b`.

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

### Solution

Our [solution][4] is simple and easy to understand. The `b_after_a` function
takes a single argument, `string`, and returns `True` if there is at least one
`b` in the string and no `a` appears after the first `b`.  We first check if
there is no `b` in the string, in which case we return `False`. We then find the
index of the first `b` in the string and slice the string after the first `b`.
Finally, we check if there is no `a` in the slice and return `True` if that is
the case; otherwise, we return `False`.

```python
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
```

### Testing

We have written a comprehensive test suite to validate our solution. We have
covered both the base and extra test cases to ensure our solution works as
expected. Runnning the test suite requires the `pytest` module, which can be
installed using `pip install pytest`.

```python
from challenge273.task2 import b_after_a


def test_examples() -> None:
    """Test if function returns correct percentage of character"""
    assert b_after_a("aabb") is True
    assert b_after_a("abab") is False
    assert b_after_a("aaa") is False
    assert b_after_a("bbb") is True
```

The test suite can be run using the following command:

```bash
$ pytest test_task2.py
```

[0]: https://perlweeklychallenge.org/blog/perl-weekly-challenge-272/
[1]: https://perlweeklychallenge.org
[2]: https://manwar.org/
[3]: ./task1.py
[4]: ./task2.py

