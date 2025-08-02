#!/usr/bin/env python3

# Challenge 058
#
# TASK #1 › Compare Version
# Reviewed by Ryan Thompson
# Compare two given version number strings v1 and v2 such that:
#
# If v1 > v2 return 1
# If v1 < v2 return -1
# Otherwise, return 0
# The version numbers are non-empty strings containing only digits, and the dot
# (“.”) and underscore (“_”) characters. (“_” denotes an alpha/development
# version, and has a lower precedence than a dot, “.”). Here are some examples:
#
#    v1   v2    Result
# ------ ------ ------
#   0.1 < 1.1     -1
#   2.0 > 1.2      1
#   1.2 < 1.2_5   -1
# 1.2.1 > 1.2_1    1
# 1.2.1 = 1.2.1    0
# Version numbers may also contain leading zeros. You may handle these how you
# wish, as long as it’s consistent.

import re
import sys

def split_version(v):
    m = re.search(r'^\d+', v)
    if not m:
        return False
    else:
        v_1 = int(m.group(0))
        if len(m.group(0)) == len(v):
            v_sep = ''
            v_rest = ''
        else:
            v_sep = v[len(m.group(0))]
            v_rest = v[len(m.group(0))+1:]
        return True, v_1, v_sep, v_rest

def compare_version(a, b):
    if a == b:
        return 0
    else:
        a_ok, a_1, a_sep, a_rest = split_version(a)
        b_ok, b_1, b_sep, b_rest = split_version(b)
        if not a_ok or not b_ok:
            return 0
        elif a_1 < b_1:
            return -1
        elif a_1 > b_1:
            return 1
        elif a_sep == b_sep:
            return compare_version(a_rest, b_rest)
        elif a_sep == '':
            return -1
        elif b_sep == '':
            return 1
        elif a_sep == '.':
            return -1
        elif b_sep == '.':
            return 1
        else:
            return compare_version(a_rest, b_rest)

a = sys.argv[1]
b = sys.argv[2]
print(compare_version(a,b))
