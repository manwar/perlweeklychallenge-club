def unique_sum(nums):
    return sum(k for k,v in Counter(nums).items() if v == 1)

# Tests
unique_sum([2,1,3,2]) # 4
unique_sum([1,1,1,1]) # 0
unique_sum([2,1,3,4]) # 10
