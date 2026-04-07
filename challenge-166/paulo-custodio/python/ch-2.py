#!/usr/bin/env python3

# Perl Weekly Challenge 166 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-166/

import os
import sys

WIDTH = 16

def read_dir(dir):
    try:
        with os.scandir(dir) as entries:
            return sorted((entry.name + '/' if entry.is_dir() else entry.name) for entry in entries if entry.name not in {'.', '..'})
    except OSError as e:
        print(f"opendir {dir}: {e}", file=sys.stderr)
        sys.exit(1)

def read_dirs(*dirs):
    return [read_dir(dir) for dir in dirs]

def print_line(*cells):
    for i in range(len(cells)):
        print(f"{cells[i]:<{WIDTH}}", end=" | " if i != len(cells) - 1 else "")
    print()

def print_diff(dirs, contents):
    # print header
    print_line(*dirs)
    print_line(*(["-" * WIDTH] * len(dirs)))

    # collect files
    files = {}
    files_dir = {}
    for i, dir in enumerate(dirs):
        for file in contents[i]:
            files[file] = True
            if file not in files_dir:
                files_dir[file] = {}
            files_dir[file][dir] = True

    # print rows
    for file in sorted(files.keys()):
        row = [file if dir in files_dir.get(file, {}) else "" for dir in dirs]
        if any(cell == "" for cell in row):
            print_line(*row)

if len(sys.argv) > 2:
    print_diff(sys.argv[1:], read_dirs(*sys.argv[1:]))
