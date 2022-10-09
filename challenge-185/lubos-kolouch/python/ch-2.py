""" Challenge 185 Task 2"""


def mask_code(in_list: list) -> list:
    """Do the magic"""

    out_list = []

    for item in in_list:
        my_count = 0
        out_char = ""
        for char in item:
            if char.isalnum() and my_count < 4:
                out_char += "x"
                my_count += 1
            else:
                out_char += char
        out_list.append(out_char)

    return out_list


assert mask_code(["ab-cde-123", "123.abc.420", "3abc-0010.xy"]) == [
    "xx-xxe-123",
    "xxx.xbc.420",
    "xxxx-0010.xy",
]

assert mask_code(["1234567.a", "a-1234-bc", "a.b.c.d.e.f"]) == [
    "xxxx567.a",
    "x-xxx4-bc",
    "x.x.x.x.e.f",
]
