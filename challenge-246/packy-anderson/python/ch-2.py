#!/usr/bin/env python

def findPandQ(a):
    p = (
      (a[2] * a[2] - a[1] * a[3])
      /
      (a[0] * a[2] - a[1] * a[1])
    )
    q = (
      (a[0] * a[3] - a[2] * a[1])
      /
      (a[0] * a[2] - a[1] * a[1])
    )
    return(p, q)


def isLinearRecurranceOfSecondOrder(a):
    (p1, q1) = findPandQ(a[0:4])
    (p2, q2) = findPandQ(a[1:5])
    if p1 != p2 or q1 != q2:
        print(f'Values for P ({p1}, {p2}) ', end='')
        print(f'and Q ({q1}, {q2}) ', end='')
        print(f'are not consistent across all five elements')
        return False
    if p1 != int(p1) or q1 != int(q1):
        print(f'Values for P ({p1}) ', end='')
        print(f'and Q ({q1}) ', end='')
        print(f'for first four elements are not integers')
        return False

    print(f'Found integer values for P ({int(p1)}) ', end='')
    print(f'and Q ({int(q1)})')
    return True

def comma_join(a):
    return ', '.join(map(str, a))

def solution(a):
    print(f'Input: @a = ({comma_join(a)})')
    result = isLinearRecurranceOfSecondOrder(a)
    print(f'Output: {result}')

print('Example 1:')
solution([1, 1, 2, 3, 5])

print('\nExample 2:')
solution([4, 2, 4, 5, 7])

print('\nExample 3:')
solution([4, 1, 2, -3, 8])