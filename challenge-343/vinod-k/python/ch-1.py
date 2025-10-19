def distance_to_zero(nums):
    if 0 in nums:
        print("Values closest to 0: 0 (distance = 0)")
        print("Exact zero wins regardless of other close values.")
        return 0

    min_distance = min(abs(num) for num in nums)
    closest = [num for num in nums if abs(num) == min_distance]

    print('Values closest to 0: ' + ' and '.join(map(str, closest)) 
          + ' (distance = ' + ' and '.join(str(abs(num)) for num in closest) + ')')
    return min_distance

# Test inputs
tests = [
    [4, 2, -1, 3, -2],
    [-5, 5, -3, 3, -1, 1],
    [7, -3, 0, 2, -8],
    [-2, -5, -1, -8],
    [-2, 2, -4, 4, -1, 1],
]

for case in tests:
    print(f"Input: @nums = ({', '.join(map(str, case))})")
    print('Output: ' + str(distance_to_zero(case)) + "\n")
