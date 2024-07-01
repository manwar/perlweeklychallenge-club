#!/usr/bin/env python3
#
# ch-2.py - Maximum Frequency
#
# 2024 Ryan Thompson <rjt@cpan.org>

# First identify which number(s) appear most often in the list,
# then return the count of all such numbers. Ex. 1, 2, 2, 4, 1, 5
# should return 4, because the matching numbers are 1,1,2,2 (freq:2)
def max_freq(ints):
    # Annoying special case for empty list
    if len(ints) == 0:
        return(0)

    # Build the frequency table (freq[n] = # of times n is in ints)
    freq = {} 
    for n in ints: freq[n] = freq.setdefault(n,0) + 1

    max_freq = max(freq.values()) # Maximal frequency

    return(sum(filter(lambda x: x == max_freq, freq.values())))

# Examples
print(max_freq([1, 2, 2, 4, 1, 5]))                  # 4
print(max_freq([1, 2, 3, 4, 5]))                     # 5
print(max_freq([1, 2, 2, 4, 6, 1, 5, 6]))            # 6
print(max_freq(['a', 'a', 'b', 'a', 'b', 'b', 'c'])) # 6
print(max_freq([3.1415926]))                         # 1
print(max_freq([]))                                  # 0
