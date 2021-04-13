#! /usr/bin/python3
def bell(x):
    aitken = [[1], []]
    row=1
    while row <= x:
        aitken[1].append(aitken[0][-1])
        for i in range(len(aitken[0])):
            aitken[1].append(aitken[0][i] + aitken[1][i])
        aitken = [aitken[1], []]
        row += 1
    return aitken[0][0]

assert bell(0) == 1
assert bell(1) == 1
assert bell(2) == 2
assert bell(3) == 5
assert bell(4) == 15
assert bell(5) == 52
assert bell(6) == 203
assert bell(7) == 877
assert bell(8) == 4140
print("ok")

# Sawyer X has resigned.
# https://perl.topicbox.com/groups/perl-core/T7a4f1bf9e069641f
# What does it mean for Perl?
# I started learning Python.
