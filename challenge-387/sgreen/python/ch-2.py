#!/usr/bin/env python3

"""Simon's solution to task 2 of The Weekly Challenge"""

from collections import defaultdict
import re
import sys


def expand_parens(match_obj: re.Match) -> str:
    """
    Expand the inner parentheses.

    Params:
        match_obj(re.Match): The second item is the string inside the
        parentheses, and the third is the multiplier value.

    Returns:
        str: The new atom count without the parentheses
    """
    multiplier = int(match_obj[2])

    # Go through each element, applying the multiplier to each one
    new_elements = defaultdict(int)
    for elements in re.findall(r"([A-Z][a-z]?)(\d+)?", match_obj[1]):
        new_elements[elements[0]] += (
            int(1 if elements[1] == "" else elements[1]) * multiplier
        )
    return "".join(f"{key}{value}" for key, value in new_elements.items())


def atom_count(input_string: str) -> str:
    """
    Count the total number of each type of atom by expanding all grouped
    multipliers. Then, format and return the final inventory as a single
    string sorted alphabetically by element name, including the total count
    only if it is greater than 1.

    Params:
        input_string (str): The chemical compound

    Returns:
        str: The number of atoms for each element
    """

    # Keep expanding inner parentheses while there is still some
    while re.search(r"\([A-Z0-9]+\)\d+", input_string, flags=re.I):
        input_string = re.sub(
            r"\(([A-Z0-9]+)\)(\d+)", expand_parens, input_string, flags=re.I
        )

    # Check that the final string is as expected
    if not re.search("^[A-Z0-9]+$", input_string, flags=re.I):
        raise ValueError("Invalid input")

    # Count the number of atoms each element has
    count_elements = defaultdict(int)
    for elements in re.findall(r"([A-Z][a-z]?)(\d+)?", input_string):
        count_elements[elements[0]] += int(1 if elements[1] == "" else elements[1])

    # Generate the output, sorted by the element alphabetically
    output = ""
    for element in sorted(count_elements):
        count = count_elements[element]
        output += element
        if count > 1:
            output += str(count)

    return output


def main():
    """Convert command line input into parameters for the function and display result"""
    result = atom_count(sys.argv[1])
    print(result)


# Call main if run from the command line
if __name__ == "__main__":
    main()
