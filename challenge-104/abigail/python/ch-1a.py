#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-1a.py
#

#
# Initialize the cache
#
cache = {0: 0, 1: 1}
max   = 50

#
# Fusc sequence is defined as:
#            ( n,                                        0 <= n <= 1
# fusc (n) = { fusc  (n / 2),                            n > 1 && n even
#            ( fusc ((n - 1) / 2) + fusc ((n + 1) / 2),  n > 1 && n odd
#
def fusc (n):
    if n not in cache:
        if n % 2 == 1:
            cache [n] = fusc ((n - 1) / 2) + fusc ((n + 1) / 2)
        else:
            cache [n] = fusc  (n      / 2)

    return cache [n]


#
# Calculate the first results of the fucs series, and print them
#
for i in range (max):
    if i > 0:
        print (' ', end = "")
    print (fusc (i), end = "")

print ("")
