def split_strings(words, separator):
    """
    Splits strings in an array by a given separator and returns non-empty strings.

    Args:
    words (List[str]): A list of strings to be split.
    separator (str): The character used as a separator.

    Returns:
    List[str]: A list of non-empty strings after splitting by the separator.
    """
    result = []
    for word in words:
        # Split each word by the separator and extend the result list
        result.extend([s for s in word.split(separator) if s])
    return result


# Tests
assert split_strings(["one.two.three", "four.five", "six"], ".") == [
    "one",
    "two",
    "three",
    "four",
    "five",
    "six",
]
assert split_strings(["$perl$$", "$$raku$"], "$") == ["perl", "raku"]

# Sample Outputs
print(split_strings(["one.two.three", "four.five", "six"], "."))
print(split_strings(["$perl$$", "$$raku$"], "$"))
