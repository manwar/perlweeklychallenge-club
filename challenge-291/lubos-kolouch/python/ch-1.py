def find_middle_index(ints):
    total_sum = sum(ints)
    left_sum = 0

    for i in range(len(ints)):
        # Right sum is total sum minus left sum and current element
        right_sum = total_sum - left_sum - ints[i]

        # Debug statements to trace computation
        print(
            f"Index: {i}, Left Sum: {left_sum}, Current Element: {ints[i]}, Right Sum: {right_sum}"
        )

        # Check if left sum equals right sum
        if left_sum == right_sum:
            return i

        # Update left sum for next iteration
        left_sum += ints[i]

    # If no middle index is found
    return -1


# Test Cases
print(find_middle_index([2, 3, -1, 8, 4]))  # Output: 3
print(find_middle_index([1, -1, 4]))  # Output: 2
print(find_middle_index([2, 5]))  # Output: -1
