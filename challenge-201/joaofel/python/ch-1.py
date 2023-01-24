# Not a full program, but a function

def missing_numbers(nums):
  return list(filter(lambda i: i not in nums, range(len(nums) + 1)))
