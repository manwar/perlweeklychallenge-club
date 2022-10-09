""" Challenge 185 Task 1"""


def convert_mac(what: str) -> str:
    """Do the conversion magic"""

    out_arr = []

    for part in what.split("."):
        out_arr.append(part[:2])
        out_arr.append(part[2:])

    return ":".join(out_arr)


assert convert_mac("1ac2.34f0.b1c2") == "1a:c2:34:f0:b1:c2"
assert convert_mac("abc1.20f1.345a") == "ab:c1:20:f1:34:5a"
