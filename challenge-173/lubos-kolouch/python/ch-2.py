""" Generate Sylvestver numbers """


def generate_sylvestver_numbers(limit: int) -> list:
    """Generate the Sylvester numbers"""

    items = [2]
    product = items[0]

    while len(items) < limit:
        items.append(product + 1)
        product *= items[-1]

    return items


assert generate_sylvestver_numbers(10) == [
    2,
    3,
    7,
    43,
    1807,
    3263443,
    10650056950807,
    113423713055421844361000443,
    12864938683278671740537145998360961546653259485195807,
    165506647324519964198468195444439180017513152706377497841851388766535868639572406808911988131737645185443,
]
