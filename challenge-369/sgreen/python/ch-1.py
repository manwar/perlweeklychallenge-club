#!/usr/bin/env python3

import re
import sys


def upper_case_letter(m: re.Match) -> str:
    """Convert the first match to an upper case letter"""
    return m.group(1).upper()


def valid_tag(input_string: str) -> str:
    """
    Generate a tag from a string based on a defined set of rules

    Params:
        input_string(str): The string to convert

    Returns:
        str: The tag
    """
    # Remove excess characters
    input_string = re.sub(r"[^\sa-zA-Z]", "", input_string)

    # Remove white space and convert to lower case
    input_string = input_string.strip().lower()

    # Capitalize subsequent words and remove the space(s)
    input_string = re.sub(r" +([a-z])", upper_case_letter, input_string)
    return "#" + input_string[:99]


def main():
    result = valid_tag(sys.argv[1])
    print(result)


if __name__ == "__main__":
    main()
