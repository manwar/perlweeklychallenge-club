def min_cost_to_equal_elements(ints, x, y):
    min_cost = float("inf")
    max_val = max(ints)
    min_val = min(ints)

    print(f"Initial array: {ints}")
    print(f"Cost for Level 1 (x): {x}")
    print(f"Cost for Level 2 (y): {y}")

    # Try making all elements equal to every value between min_val and max_val
    for target in range(min_val, max_val + 1):
        cost = 0
        print(f"\nTrying to make all elements equal to: {target}")

        for num in ints:
            diff = abs(target - num)
            print(f"Difference for element {num} to target {target}: {diff}")

            # Calculate cost using level 2 operations first, then level 1 if needed
            if y < 2 * x:
                # Using Level 2 operations where possible
                level_2_ops = diff // 2
                level_1_ops = diff % 2
                cost_addition = (level_2_ops * y) + (level_1_ops * x)
                print(
                    f"Using Level 2 and Level 1. Cost to adjust {num} to {target}: {cost_addition}"
                )
            else:
                # Using only Level 1 operations
                cost_addition = diff * x
                print(
                    f"Using only Level 1. Cost to adjust {num} to {target}: {cost_addition}"
                )

            cost += cost_addition

        print(f"Total cost to make all elements {target}: {cost}")
        min_cost = min(min_cost, cost)

    return min_cost


# Example 1
ints1 = [4, 1]
x1 = 3
y1 = 2
print(
    f"Minimum cost: {min_cost_to_equal_elements(ints1, x1, y1)}"
)  # Expected Output: 9

# Example 2
ints2 = [2, 3, 3, 3, 5]
x2 = 2
y2 = 1
print(
    f"Minimum cost: {min_cost_to_equal_elements(ints2, x2, y2)}"
)  # Expected Output: 6
