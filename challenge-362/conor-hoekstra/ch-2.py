from num2words import num2words


def spellbound_sorting(nums):
    return sorted(nums, key=lambda n: num2words(n))


# Tests
assert spellbound_sorting([6, 7, 8, 9, 10]) == [8, 9, 7, 6, 10]
assert spellbound_sorting([-3, 0, 1000, 99]) == [-3, 99, 1000, 0]
assert spellbound_sorting([1, 2, 3, 4, 5]) == [5, 4, 1, 3, 2]
assert spellbound_sorting([0, -1, -2, -3, -4]) == [-4, -1, -3, -2, 0]
assert spellbound_sorting([100, 101, 102]) == [100, 101, 102]

print("All tests passed!")
