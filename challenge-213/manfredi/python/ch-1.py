#!/usr/bin/env python3
# Python 3.9.2 on Debian GNU/Linux 11 (bullseye)

print('challenge-213-task1')

# Task 1: Fun Sort
# You are given a list of positive integers.
# Write a script to sort the all even integers first then all odds in ascending order.

def fun_sort(items: list[int]) -> list[int]:
    items.sort()
    out_even = [item for item in items if not item % 2 ]
    out_odd  = [item for item in items if item % 2 ]
    out_even.extend(out_odd)
    return out_even
    
def main():
    print(fun_sort([3, 6, 1, 4, 5, 2]))
    print(fun_sort([1, 2]))
    print(fun_sort([1]))
    

if __name__ == '__main__':
    main()
