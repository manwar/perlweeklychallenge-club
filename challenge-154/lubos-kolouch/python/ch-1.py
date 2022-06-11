""" Challenge 154 Task 1 LK """
from itertools import permutations


def find_missing(what: list):
    """Find the missing permutations"""

    all_perms = permutations("PERL")

    output = []

    for perm in all_perms:
        look_str = "".join(perm)
        if look_str not in what:
            output.append(look_str)

    return output


assert find_missing(
    [
        "PELR",
        "PREL",
        "PERL",
        "PRLE",
        "PLER",
        "PLRE",
        "EPRL",
        "EPLR",
        "ERPL",
        "ERLP",
        "ELPR",
        "ELRP",
        "RPEL",
        "RPLE",
        "REPL",
        "RELP",
        "RLPE",
        "RLEP",
        "LPER",
        "LPRE",
        "LEPR",
        "LRPE",
        "LREP",
    ]
) == ["LERP"]
