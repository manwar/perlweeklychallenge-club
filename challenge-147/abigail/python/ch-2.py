#!/usr/local/bin/python3

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-147
#

#
# Run as: python ch-2.py
#

pentagon = {}
p = 0
n = 0
done = False


while not done:
    p = p + n + n + n + 1
    n = n + 1
    pentagon [p] = True

    for seen in pentagon:
        if seen + seen <= p and (p - seen) in pentagon \
                            and (p - seen - seen) in pentagon:
            print (seen, p - seen)
            done = True
            break
        if done:
            break
