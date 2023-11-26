from typing import List, Tuple


def find_missing_members(
    arr1: list[int], arr2: list[int]
) -> tuple[list[int], list[int]]:
    # Convert lists to sets for unique elements
    set_arr1, set_arr2 = set(arr1), set(arr2)

    # Find unique missing members in each array
    missing_in_arr2 = sorted(list(set_arr1 - set_arr2))
    missing_in_arr1 = sorted(list(set_arr2 - set_arr1))

    return missing_in_arr2, missing_in_arr1


# Testing
assert find_missing_members([1, 2, 3], [2, 4, 6]) == ([1, 3], [4, 6])
assert find_missing_members([1, 2, 3, 3], [1, 1, 2, 2]) == ([3], [])

# Running the script
if __name__ == "__main__":
    arr1, arr2 = [1, 2, 3, 3], [1, 1, 2, 2]
    print(f"Input: arr1 = {arr1}, arr2 = {arr2}")
    result = find_missing_members(arr1, arr2)
    print(f"Output: {result}")
