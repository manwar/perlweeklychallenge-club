from sys import argv

def divide(m, n):
    # handle 0 values first
    if n == 0:
        raise ZeroDivisionError('integer division or modulo by zero')
    if m == 0:
        return 0

    # sign of the result
    sign = -1 if (m < 0 and n > 0) or (m > 0 and n < 0) else 1

    # now count how many times we can subtract abs(n) from abs(m)
    (m, n) = tuple(abs(x) for x in (m,n))
    count = 0
    while m >= n:
        m -= n
        count += 1

    if sign == -1 and m > 0:
        return -(count + 1)
    else:
        return count * sign

m, n = tuple(int(x) for x in argv[1:3])
print(divide(m, n))
