import sys

def left_right_sums(ints):
    total_sum = sum(ints)
    left_sum = 0
    for item in ints:
        right_sum = total_sum - left_sum - item
        yield left_sum, right_sum
        left_sum += item

ints = [int(x) for x in sys.argv[1:]]
middle_index = next(
    (i for i, (left_sum, right_sum) in enumerate(left_right_sums(ints))
     if left_sum == right_sum),
    -1)
print(middle_index)
