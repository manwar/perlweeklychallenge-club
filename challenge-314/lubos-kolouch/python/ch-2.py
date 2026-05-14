#!/usr/bin/env python3
"""Solution for Perl Weekly Challenge 314 Task 2: Sort Column"""


def delete_columns(str_list):
    """Return the number of columns to delete so that each column is sorted lexicographically."""
    if not str_list:
        return 0
    n_cols = len(str_list[0])
    delete_count = 0
    for col in range(n_cols):
        # Check if column is sorted
        for row in range(1, len(str_list)):
            if str_list[row - 1][col] > str_list[row][col]:
                delete_count += 1
                break
    return delete_count


# Test cases from the blog
if __name__ == "__main__":
    test_cases = [
        (["swpc", "tyad", "azbe"], 2),
        (["cba", "daf", "ghi"], 1),
        (["a", "b", "c"], 0),
    ]

    for str_list, expected in test_cases:
        result = delete_columns(str_list)
        status = (
            "OK" if result == expected else f"FAILED: got {result}, expected {expected}"
        )
        print(f"delete_columns({str_list}) = {result} [{status}]")
