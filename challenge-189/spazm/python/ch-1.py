#!/usr/bin/env python


def greater_character(chars, target):
    """
    Sort the input and return the first element greater than target
    return target if no elements match
    """
    return next((c for c in sorted(chars) if c > target), target)


assert greater_character([*"emug"], "b") == "e"
assert greater_character([*"dcef"], "a") == "c"
assert greater_character([*"jar"], "o") == "r"
assert greater_character([*"dca f"], "a") == "c"
assert greater_character([*"tgal"], "v") == "v"
