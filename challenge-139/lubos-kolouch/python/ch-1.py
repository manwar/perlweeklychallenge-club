def is_jort_sorted(what):

    return what == sorted(what)


assert is_jort_sorted([1, 2, 3, 4, 5]) == 1
assert is_jort_sorted([1, 3, 2, 4, 5]) == 0
