cache = {}


def get_houses_max(houses: list):
    """Calculate the best way through the houses"""

    try:
        return cache[",".join(map(str, houses))]
    except KeyError:
        pass

    max_value = 0
    house_index = 0

    for house_index, _ in enumerate(houses[2:]):
        next_houses_values = get_houses_max(houses[2 + house_index :])
        if next_houses_values > max_value:
            max_value = next_houses_values

    cache[",".join(map(str, houses))] = houses[0] + max_value
    return houses[0] + max_value


assert get_houses_max([2, 4, 5]) == 7
cache = {}
assert get_houses_max([4, 2, 3, 6, 5, 3]) == 13
