#!/usr/bin/python3
#
# This is just me learning a bit of python.
# Look at the perl solution for a discussion of the details.

def exact_change(*args):
    change = {}
    print("Input: ", end="")
    first = 1
    for i in args:
        if first:
            print("(", end="")
            first = 0
        else:
            print(", ", end="")
        print(i, end="")
    print(")")

    for bill in args:
        change[bill] = change.get(bill, 0) + 1
        to_return = bill - 5
        for return_bill in [10, 5]:
            change[return_bill] = change.get(return_bill, 0)
            while to_return >= return_bill and change[return_bill] >= 1:
                to_return -= return_bill
                change[return_bill] -= 1
        if to_return > 0:
            print("Output: false")
            return
    print("Output: true")


exact_change(5, 5, 5, 10, 20);
exact_change(5, 5, 10, 10, 20);
exact_change(5, 5, 5, 20);
