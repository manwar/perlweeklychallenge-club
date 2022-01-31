""" Challenge 149 Task 1"""
fibs = []
fib_hash = {}

fibs.append(0)
fibs.append(1)

fib_hash[0] = 1
fib_hash[1] = 1

def gen_more_fibs(limit:int):
    """ Generate more Fibonacci numbers if needed"""

    while fibs[-1] < limit:
        new_fib =fibs[-1] + fibs[-2]
        fibs.append(new_fib)
        fib_hash[new_fib] = 1


def get_numbers(what: int):
    """Get the list as required"""

    count = 0
    pos = 0

    output = []

    while count < what:
        gen_more_fibs(pos)
        try:
            fib_hash[sum(list(map(int, str(pos))))]
            output.append(pos)
            count += 1
        except KeyError:
            pass
        pos += 1

    return output

assert get_numbers(20) == [0, 1, 2, 3, 5, 8, 10, 11, 12, 14, 17, 20, 21, 23, 26, 30, 32, 35, 41, 44]
