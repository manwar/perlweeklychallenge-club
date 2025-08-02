def find_odd_character(s: str, t: str) -> str:
    """
    Finds the additional character in string t.

    :param s: Original string.
    :param t: Modified string with one extra character.
    :return: The additional character.
    """
    from collections import Counter

    count_s = Counter(s)
    count_t = Counter(t)

    for char in count_t:
        if count_t[char] > count_s.get(char, 0):
            return char

    return ""


# Tests
assert find_odd_character("Perl", "Preel") == "e"
assert find_odd_character("Weekly", "Weeakly") == "a"
assert find_odd_character("Box", "Boxy") == "y"
