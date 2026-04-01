#!/usr/bin/env python3

# Perl Weekly Challenge 182 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-182/

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
