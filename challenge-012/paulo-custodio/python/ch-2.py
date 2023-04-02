#!/usr/bin/python3

# Challenge 012
#
# Challenge #2
# Write a script that finds the common directory path, given a collection of
# paths and directory separator. For example, if the following paths are
# supplied.
# /a/b/c/d
# /a/b/cd
# /a/b/cc
# /a/b/c/d/e
# and the path separator is /. Your script should return /a/b as common
# directory path.

import sys

def extract_common_prefix(paths):
    # check if all paths have common prefix
    dir = None
    for path in paths:
        if len(path)==0:
            return False, ""
        elif dir is None:
            dir = path[0]
        else:
            if path[0]!=dir:
                return False, ""

    # remove common prefix
    for path in paths:
        path.pop(0)

    return True, dir

def common_prefix(sep, paths):
    # split paths by separator
    for i in range(len(paths)):
        paths[i] = paths[i].split(sep)

    # find common prefix
    prefix = []
    while True:
        found, dir = extract_common_prefix(paths)
        if not found:
            break
        prefix.append(dir)

    return sep.join(prefix)

sep = sys.stdin.readline().rstrip()
paths = [s.rstrip() for s in sys.stdin.readlines()]
print(common_prefix(sep, paths))
