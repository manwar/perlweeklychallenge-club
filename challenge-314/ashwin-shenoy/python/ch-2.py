def solution(string_list: list[str]) -> int:
    """Solution to task 2.

    Title: "Sort Column"

    You are given a list of strings of same length.
    Write a script to make each column sorted lexicographically by deleting any non sorted columns.
    Return the total columns deleted.

    URL: https://theweeklychallenge.org/blog/perl-weekly-challenge-314/

    Algorithm details:

        Time complexity:

            - Best case scenario    : O(NM)
            - Worst case scenario   : O(NM)
            - Average case scenario : O(NM)

        Space complexity:

            - Best case scenario    : O(N)
            - Worst case scenario   : O(N)
            - Average case scenario : O(N)

        where N = Length of the string.
              M = Number of strings.

    Args:
        string_list: A list of strings (of equal lengths).

    Returns:
        The number of columns to be deleted to make the remaining string "columns"
        lexicographically sorted.
    """
    num_columns_deleted = 0

    for idx in range(len(string_list[0])):
        temp_string_list = []

        for string in string_list:
            temp_string_list.append(string[idx])

        if not (temp_string_list == sorted(temp_string_list)):
            num_columns_deleted += 1

    return num_columns_deleted


if __name__ == "__main__":
    print(f"Result: {solution()}")
