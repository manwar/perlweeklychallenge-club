def reverse_vowels(s: str) -> str:
    """
    Reverse the vowels in a given string while preserving the case.

    Args:
    s (str): The input string.

    Returns:
    str: The string with vowels reversed.

    Example:
    >>> reverse_vowels("Raku")
    'Ruka'
    """
    vowels = "aeiouAEIOU"
    # Extract vowels from the string in reverse order
    reverse_vowel_list = [char for char in s if char in vowels][::-1]

    # Replace vowels in the string with reversed vowels
    result = []
    reversed_vowels_iter = iter(reverse_vowel_list)
    for char in s:
        if char in vowels:
            # Ensure the case of the vowel is preserved
            next_vowel = next(reversed_vowels_iter, char)
            result.append(
                next_vowel.swapcase()
                if char.isupper() != next_vowel.isupper()
                else next_vowel
            )
        else:
            result.append(char)
    return "".join(result)


# Tests
assert reverse_vowels("Raku") == "Ruka"
assert reverse_vowels("Perl") == "Perl"
assert reverse_vowels("Julia") == "Jaliu"
assert reverse_vowels("Uiua") == "Auiu"

# Run the function with the test cases
if __name__ == "__main__":
    for test in ["Raku", "Perl", "Julia", "Uiua"]:
        print(f"{test} -> {reverse_vowels(test)}")
