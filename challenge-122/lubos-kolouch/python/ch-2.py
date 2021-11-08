# Perl weekly challenge 122 Task 2 - Basketball Points

iter_count = 0


def iterate(arr, target_sum):
    """ Iteratively print the possibilities """
    global iter_count

    arr_sum = sum(arr)

    if arr_sum == target_sum:
        print("*********** SCORE: ", end="")
        print(" ".join(list(map(str, arr))))
        iter_count += 1

    if arr_sum >= target_sum:
        return

    # expand the array and try again
    new_arr = arr.copy()
    new_arr.append(1)
    print(" ".join(list(map(str, arr))), end="")
    print(" > ", end="")
    print(" ".join(list(map(str, new_arr))))
    iterate(new_arr, target_sum)

    # cannot expand, try increasing the last poing
    new_arr = arr.copy()
    if ((new_arr) and (new_arr[-1] < target_sum) and (new_arr[-1] < 3)):
        new_arr[-1] += 1
        print(" ".join(list(map(str, arr))), end="")
        print(" ^ ", end="")
        print(" ".join(list(map(str, new_arr))))
        iterate(new_arr, target_sum)


def print_points(target_sum: int):
    iterate([], target_sum)


iter_count = 0
print_points(4)
assert iter_count == 7

iter_count = 0
print_points(5)
assert iter_count == 13
