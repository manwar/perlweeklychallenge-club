#!/usr/bin/env python3

# Challenge 112
#
# TASK #1 - Canonical Path
# Submitted by: Mohammad S Anwar
# You are given a string path, starting with a slash '/'.
#
# Write a script to convert the given absolute path to the simplified canonical
# path.
#
# In a Unix-style file system:
#
# - A period '.' refers to the current directory
# - A double period '..' refers to the directory up a level
# - Multiple consecutive slashes ('//') are treated as a single slash '/'
# The canonical path format:
#
# - The path starts with a single slash '/'.
# - Any two directories are separated by a single slash '/'.
# - The path does not end with a trailing '/'.
# - The path only contains the directories on the path from the root directory
#   to the target file or directory
# Example
# Input: "/a/"
# Output: "/a"
#
# Input: "/a/b//c/"
# Output: "/a/b/c"
#
# Input: "/a/b/c/../.."
# Output: "/a"

import sys
import re

def canon(path):
    def replace(srch, rpl, s):
        while True:
            s, count = re.subn(srch, rpl, s)
            if count==0:
                return s

    path = replace(r"/\./", "/", path)
    path = replace(r"/\.$", "/", path)
    path = replace(r"/[^\/\.]+/\.\./", "/", path)
    path = replace(r"/[^\/\.]+/\.\.$", "/", path)
    path = re.sub(r"/+", "/", path)
    path = re.sub(r"/$", "", path)
    return path

print(canon(sys.argv[1]))
