""" Challenge 157 Task 1 LK Python """


def calc_am(what: list) -> float:
    """Return the arithmetic mean"""
    return round(sum(what) / len(what), 1)


def calc_gm(what: list) -> float:
    """Return the geometric mean"""

    product: int = 1

    for num in what:
        product *= num

    return round(abs(pow(product, 1 / len(what))), 1)


def calc_hm(what: list) -> float:
    """Return harmonic mean"""

    my_sum = 0

    for item in what:
        my_sum += 1 / item

    return round(len(what) / my_sum, 1)


def calc_means(what: list) -> str:
    """Do the excercise"""

    return f"AM={calc_am(what)}, GM={calc_gm(what)}, HM={calc_hm(what)}"


assert calc_means([1, 3, 5, 6, 9]) == "AM=4.8, GM=3.8, HM=2.8"

assert calc_means([2, 4, 6, 8, 10]) == "AM=6.0, GM=5.2, HM=4.4"

assert calc_means([1, 2, 3, 4, 5]) == "AM=3.0, GM=2.6, HM=2.2"
