""" Challenge 184 Task 2"""
import re


def split_array(my_input: list) -> list:
    """Do the task"""

    list09 = []
    listaz = []

    for item in my_input:

        temp09 = []
        tempaz = []

        for char in item:

            if re.match(r"\d", char):
                temp09.append(int(char))

            if re.match(r"[a-z]", char):
                tempaz.append(char)

            # ignore if there is some other garbage

        if temp09:
            list09.append(temp09)

        if tempaz:
            listaz.append(tempaz)

    return [list09, listaz]


assert split_array(["a 1 2 b 0", "3 c 4 d"]) == [
    [[1, 2, 0], [3, 4]],
    [["a", "b"], ["c", "d"]],
]

assert split_array(["1 2", "p q r", "s 3", "4 5 t"]) == [
    [[1, 2], [3], [4, 5]],
    [["p", "q", "r"], ["s"], ["t"]],
]
