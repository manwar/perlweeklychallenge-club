""" Challenge 184 Task 1"""


def replace_chars(my_input: list) -> list:
    """Do the exercise"""

    output = []

    for pos, item in enumerate(my_input):

        # assuming to rotate the sequence if more than 100 words
        next_item = f"{pos % 100:02d}"

        output.append(next_item + item[2:])

    return output


assert replace_chars(["ab1234", "cd5678", "ef1342"]) == ["001234", "015678", "021342"]
assert replace_chars(["pq1122", "rs3334"]) == ["001122", "013334"]
