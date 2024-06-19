"""
## Task 1: Percentage of Character

**Submitted by:** [Mohammad Sajid Anwar][0]

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

[0]: https://manwar.org/
"""

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
