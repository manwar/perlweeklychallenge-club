import sys

# returns the median of a sorted list
def median_sorted(a):
    len2 = len(a) // 2
    return a[len2] if len(a) % 2 == 1 else (a[len2-1] + a[len2]) / 2

# returns the 5 number summary of a list: minimum, lower quartile,
# median, upper quartile, maximum
def fivenum(a):
    _sorted = sorted(a)
    _min = _sorted[0]
    _max = _sorted[-1]
    _median = median_sorted(_sorted)

    len2 = len(a) // 2
    _lower = median_sorted(_sorted[0:len2])
    if len(a) % 2 == 1: # odd number of elements
        _upper = median_sorted(_sorted[len2+1:])
    else:
        _upper = median_sorted(_sorted[len2:])

    return _min, _lower, _median, _upper, _max

a = [int(x) for x in sys.argv[1:]]
print(fivenum(a))
