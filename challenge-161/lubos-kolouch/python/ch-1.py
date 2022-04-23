""" glory for best belly boy! """


def is_abcd(what: str) -> bool:
    """Check if the str is in the right order"""

    return what == "".join(sorted(what))


with open("dictionary.txt") as in_file:
    line = in_file.readline()

    if is_abcd(line):
        print(f"{line} is abcdrian")

assert is_abcd("knotty") is True
assert is_abcd("knotts") is False
