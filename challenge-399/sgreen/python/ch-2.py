#!/usr/bin/env python3

"""Simon's solution to task 2 of The Weekly Challenge"""

import re
import sys


def longest_absolute_path(paths: str) -> int:
    """
    Return the length of the longest absolute path to a file in the
    abstracted file system. If there is no file in the system, return 0.

    Params:
        paths(str): A tree structure separated by new lines, indented by tabs

    Returns:
        int: The length of the longest path that matches the criteria
    """
    current_path = []
    longest_path = 0

    # Work through each line
    for line in paths.split("\n"):
        # Separate the leading tabs from the rest of the line.
        tabs, file = re.search(r"^(\t*)(.*)$", line).groups() # type: ignore
        path_pos = len(tabs)

        # Update the current path as required,
        current_path = [*current_path[:path_pos], file]
        length = len("/".join(current_path))

        # If the file contains a dot, and is the longest, update longest_path
        if "." in file and length > longest_path:
            longest_path = length

    return longest_path


def main():
    """Convert command line input into parameters for the function and display result"""
    result = longest_absolute_path(sys.argv[1])
    print(result)


# Call main if run from the command line
if __name__ == "__main__":
    main()
