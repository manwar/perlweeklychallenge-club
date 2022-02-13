import re


def get_min_depth(my_input: str):
    """Calculate the depth"""
    # Input: '1 | 2 3 | 4 5'

    # iterate through the layers. If the next layer does not have 2^n items,
    # there must be a leaf node

    layers = my_input.split("|")

    for layer_count, _ in enumerate(layers, 1):
        # if not defined means we are at the last layer
        try:
            layers[layer_count] = re.sub(r"^\s+", "", layers[layer_count])
            layers[layer_count] = re.sub(r"\s+$", "", layers[layer_count])

            items_count = len(re.split(r"\s+", layers[layer_count]))
        except IndexError:
            return layer_count

        if items_count != 2**layer_count:
            return layer_count

    return None


assert get_min_depth("1 | 2 3 | 4 5") == 2
assert get_min_depth("1 | 2 3 | 4 *  * 5 | * 6") == 3
assert get_min_depth("1 | 20 3 | 4 *  * 5 | * 6") == 3

assert get_min_depth("1 | 2 3") == 2
