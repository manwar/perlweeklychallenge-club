def build_set_from_index(ints, starting_index):
    iset = [
            ints[starting_index],
            ]
    for ints_index in range(1, len(ints)):
        pindex = iset[ints_index - 1]
        value = ints[pindex]
        if value in iset:
            break
        iset.append(value)
    return iset

def return_longest_length(ints):
    max_length = 0
    for i in range(0, len(ints)):
        iset = build_set_from_index(ints, i)
        iset_length = len(iset)
        if iset_length > max_length:
            max_length = iset_length
    return max_length
