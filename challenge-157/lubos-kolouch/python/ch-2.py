""" Challenge 157 Task 2 LK """

import re

import numpy as np


def is_brazilian(what: int) -> bool:
    """Test if the num is brazilian"""

    for i in range(2, what - 1):

        base_rep = np.base_repr(what, i)

        if re.match(r"^(.)\1+$", base_rep):
            return True

    return False


assert is_brazilian(7) == 1
assert is_brazilian(6) == 0
assert is_brazilian(8) == 1
