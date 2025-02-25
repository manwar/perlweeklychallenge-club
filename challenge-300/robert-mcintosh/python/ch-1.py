from itertools import permutations

def generate_permutations(n)
    iterable = list(range(1, n + 1))
    return permutations(iterable)

def count_beautiful_arrangements(perms):
    num_beautiful_arr = 0
    for perm in perms:
        is_beautiful_arr = True
        for value_index, value in enumerate(perm):
            if value % (value_index + 1) == 0:
                continue
            elif (value_index + 1) % value == 0:
                continue
            else:
                is_beautiful_arr = False
                break
        if is_beautiful_arr == True:
            num_beautiful_arr += 1
    return num_beautiful_arr
