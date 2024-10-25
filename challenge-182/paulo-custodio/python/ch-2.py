#!/usr/bin/env python3

# Challenge 182
#
# Task 2: Common Path
# Submitted by: Julien Fiegehenn
#
# Given a list of absolute Linux file paths, determine the deepest path to the
# directory that contains all of them.
# Example
#
# Input:
#     /a/b/c/1/x.pl
#     /a/b/c/d/e/2/x.pl
#     /a/b/c/d/3/x.pl
#     /a/b/c/4/x.pl
#     /a/b/c/d/5/x.pl
#
# Ouput:
#     /a/b/c

import sys

def extract_common_prefix(paths):
    # check if all paths have the same prefix
    dir_prefix = None
    for i in range(len(paths)):
        if not paths[i]:  # path empty
            return None
        if i == 0:
            dir_prefix = paths[i][0]  # first path
        else:
            if dir_prefix != paths[i][0]:  # not same prefix
                return None

    # all have dir_prefix, shift if out
    for path in paths:
        path.pop(0)

    return dir_prefix


def common_prefix(sep, *paths):
    # split paths by separator
    paths = [path.split(sep) for path in paths]

    # find common prefix
    prefix = []
    while (dir_prefix := extract_common_prefix(paths)) is not None:
        prefix.append(dir_prefix)

    return sep.join(prefix)


sep = sys.argv[1]
paths = sys.argv[2:]
print(common_prefix('/', *paths))
