def solution(s1: str, s2: str, s3: str) -> int:
    """Solution to task 1.

    Title: "Equal Strings"

    You are given three strings.
    You are allowed to remove the rightmost character of a string to make all equals.
    Write a script to return the number of operations to make it equal otherwise -1.

    URL: https://theweeklychallenge.org/blog/perl-weekly-challenge-314/

    Algorithm details:

        Time complexity:

            - Best case scenario    : O(N)
            - Worst case scenario   : O(N)
            - Average case scenario : O(N)

        Space complexity:

            - Best case scenario    : O(1)
            - Worst case scenario   : O(1)
            - Average case scenario : O(1)

    Args:
        s1: The first string.
        s2: The second string.
        s3: The third string.

    Returns:
        The number of operations required to make all 3 strings equal.
    """
    num_operations = 0
    max_string_length = max(len(s1), len(s2), len(s3))

    for idx in range(max_string_length, 0, -1):
        if len(s1) >= idx:
            s1 = s1[: -(idx - max_string_length + 1)]
            num_operations += 1

        if len(s2) >= idx:
            s2 = s2[: -(idx - max_string_length + 1)]
            num_operations += 1

        if len(s3) >= idx:
            s3 = s3[: -(idx - max_string_length + 1)]
            num_operations += 1

        # If all 3 strings are equal (but not equal to an empty string), immediately
        # return the number of operations.
        if s1 == s2 == s3 != "":
            return num_operations

    return -1


if __name__ == "__main__":
    print(f"Result: {solution(['swpc', 'tyad', 'azbe'])}")
