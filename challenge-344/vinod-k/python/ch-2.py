from typing import List, Tuple

def can_build_target(source: List[List[int]], target: List[int]) -> Tuple[bool, List[List[int]]]:
    target_string = "".join(map(str, target))
    source_used = [False] * len(source)
    used_order = []

    while target_string:
        match_found_in_cycle = False
        
        for i in range(len(source)):
            if source_used[i]:
                continue

            sub_list = source[i]
            source_pattern = "".join(map(str, sub_list))

            if target_string.startswith(source_pattern):
                target_string = target_string[len(source_pattern):]
                source_used[i] = True
                used_order.append(sub_list)
                match_found_in_cycle = True

        if not match_found_in_cycle:
            return False, []
        
    return True, used_order

def format_list_of_lists(arr_list: List[List[int]]) -> str:
    return "(" + ", ".join([f"[{', '.join(map(str, sub))}]" for sub in arr_list]) + ")"

def format_list(arr: List[int]) -> str:
    return f"({', '.join(map(str, arr))})"

#Example 1
source1 = [[2, 3], [1], [4]]
target1 = [1, 2, 3, 4]

result1, order1 = can_build_target(source1, target1)

print(f"Input: source = {format_list_of_lists(source1)}")
print(f"Input: target = {format_list(target1)}")
print(f"Output: {str(result1).lower()}")

if result1:
    print(f"Use in the order: {format_list_of_lists(order1)}")
print("\n")

#Example 2
source2 = [[1,3], [2,4]]
target2 = [1, 2, 3, 4]

result2, order2 = can_build_target(source2, target2)

print(f"Input: source = {format_list_of_lists(source2)}")
print(f"Input: target = {format_list(target2)}")
print(f"Output: {str(result2).lower()}")

if result2:
    print(f"Use in the order: {format_list_of_lists(order2)}")
print("\n")

#Example 3
source3 = [[9,1], [5,8], [2]]
target3 = [5, 8, 2, 9, 1]

result3, order3 = can_build_target(source3, target3)

print(f"Input: source = {format_list_of_lists(source3)}")
print(f"Input: target = {format_list(target3)}")
print(f"Output: {str(result3).lower()}")

if result3:
    print(f"Use in the order: {format_list_of_lists(order3)}")
print("\n")

#Example 4
source4 = [[1], [3]]
target4 = [1, 2, 3]

result4, order4 = can_build_target(source4, target4)

print(f"Input: source = {format_list_of_lists(source4)}")
print(f"Input: target = {format_list(target4)}")
print(f"Output: {str(result4).lower()}")

if result4:
    print(f"Use in the order: {format_list_of_lists(order4)}")
print("\n")

#Example 5
source5 = [[7,4,6]]
target5 = [7, 4, 6]

result5, order5 = can_build_target(source5, target5)

print(f"Input: source = {format_list_of_lists(source5)}")
print(f"Input: target = {format_list(target5)}")
print(f"Output: {str(result5).lower()}")

if result5:
    print(f"Use in the order: {format_list_of_lists(order5)}")
