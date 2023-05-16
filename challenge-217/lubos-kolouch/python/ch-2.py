from functools import cmp_to_key


def highest_value(nums):
    nums = map(str, nums)  # convert numbers to strings
    result = ''.join(sorted(nums, key=cmp_to_key(
        lambda x, y: 1 if y+x > x+y else -1)))
    return int(result)


print(highest_value([1, 23]))
print(highest_value([10, 3, 2]))
print(highest_value([31, 2, 4, 10]))
print(highest_value([5, 11, 4, 1, 2]))
print(highest_value([1, 10]))
