#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os


def k_directory_diff(dirs):
    all_files = set()
    dir_files = {}

    for directory in dirs:
        files = set(os.listdir(directory))
        all_files |= files
        dir_files[directory] = files

    missing_files = {f: [] for f in all_files}

    for directory, files in dir_files.items():
        for file in all_files:
            if file not in files:
                missing_files[file].append(directory)

    for file, directories in missing_files.items():
        if directories:
            print(file, "is missing in", ", ".join(directories))


dirs = ["dir_a", "dir_b", "dir_c"]
k_directory_diff(dirs)
