""" Challenge 160 Task 1"""

from num2words import num2words


def four_magic(what: int) -> str:
    """Do the conversion magic"""

    output = []

    while 1:
        new_num = len(num2words(what))

        if what == 4:
            output.append(num2words(what) + " is magic.")
            break
        output.append(num2words(what) + " is " + num2words(new_num))
        what = new_num

    out_str = ", ".join(output)

    return out_str.capitalize()


assert four_magic(5) == "Five is four, four is magic."
assert four_magic(7) == "Seven is five, five is four, four is magic."
assert four_magic(6) == "Six is three, three is five, five is four, four is magic."
