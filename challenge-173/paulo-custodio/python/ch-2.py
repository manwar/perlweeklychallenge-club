#!/usr/bin/env python3

# Challenge 173
#
# Task 2: Sylvester's sequence
# Submitted by: Mohammad S Anwar
#
# Write a script to generate first 10 members of Sylvester's sequence. For more
# informations, please refer to the wikipedia page.
#
# Output
#
# 2
# 3
# 7
# 43
# 1807
# 3263443
# 10650056950807
# 113423713055421844361000443
# 12864938683278671740537145998360961546653259485195807
# 165506647324519964198468195444439180017513152706377497841851388766535868639572406808911988131737645185443

import sys

def sylvester_seq(N):
    n = [2]
    prod = 2
    while len(n) < N:
        term = prod + 1
        n.append(term)
        prod *= term
    return n

if len(sys.argv) != 2:
    raise ValueError("usage: ch-2.py n")
print(", ".join(map(str, sylvester_seq(int(sys.argv[1])))))
