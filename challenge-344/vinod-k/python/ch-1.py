from typing import List

def add_to_array_form(ints: List[int], x: int) -> List[int]:
    int_string = "".join(map(str, ints))
    int_form = int(int_string)

    sum_result = int_form + x

    sum_string = str(sum_result)
    result_array = [int(digit) for digit in sum_string]

    return result_array

#Tests
#Example 1
ints1 = [1, 2, 3, 4]
x1 = 12
output1 = add_to_array_form(ints1, x1)

print(f"Input Array: {ints1}")
print(f"Input X: {x1}")
print(f"Output Array: {output1}\n")

#Example 2
ints2 = [2, 7, 4]
x2 = 181
output2 = add_to_array_form(ints2, x2)

print(f"Input Array: {ints2}")
print(f"Input X: {x2}")
print(f"Output Array: {output2}\n")

#Example 3
ints3 = [9, 9, 9]
x3 = 1
output3 = add_to_array_form(ints3, x3)

print(f"Input Array: {ints3}")
print(f"Input X: {x3}")
print(f"Output Array: {output3}\n")

#Example 4
ints4 = [1, 0, 0, 0, 0]
x4 = 9999
output4 = add_to_array_form(ints4, x4)

print(f"Input Array: {ints4}")
print(f"Input X: {x4}")
print(f"Output Array: {output4}\n")

#Example 5
ints5 = [0]
x5 = 1000
output5 = add_to_array_form(ints5, x5)

print(f"Input Array: {ints5}")
print(f"Input X: {x5}")
print(f"Output Array: {output5}\n")
