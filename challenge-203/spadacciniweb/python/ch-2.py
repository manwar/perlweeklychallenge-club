# Task 2: Copy Directory
# Submitted by: Julien Fiegehenn
# 
# You are given path to two folders, $source and $target.
# Write a script that recursively copy the directory from $source to $target except any files.
# 
# Example
# Input: $source = '/a/b/c' and $target = '/x/y'
# 
# Source directory structure:
# 
# ├── a
# │   └── b
# │       └── c
# │           ├── 1
# │           │   └── 1.txt
# │           ├── 2
# │           │   └── 2.txt
# │           ├── 3
# │           │   └── 3.txt
# │           ├── 4
# │           └── 5
# │               └── 5.txt
# 
# Target directory structure:
# 
# ├── x
# │   └── y
# 
# Expected Result:
# 
# ├── x
# │   └── y
# |       ├── 1
# │       ├── 2
# │       ├── 3
# │       ├── 4
# │       └── 5

import os
import re
import sys

source = input("path source: ")
if not(os.path.exists(source)):
    sys.exit("{0} directory does not exist.\n".format(source))

target = input("path target: ")
if not(os.path.exists(target)):
    sys.exit("{0} directory does not exist.\n".format(target))

dirs = []

for path, subdirs, files in os.walk(source):
    for subdir in subdirs:
        if len(path) == len(source):
            dirs.append(subdir)
        else:
            dirs.append( os.path.join(path[len(source)+1:], subdir))

for dir in dirs:
    path = os.path.join(target, dir)
    os.mkdir(path)
