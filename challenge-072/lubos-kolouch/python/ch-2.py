#!/usr/bin/env python
# -*- coding: utf-8 -*-


def display_lines(file_name: str, a: int, b: int) -> None:
    with open(file_name, "r") as file:
        lines = file.readlines()
        for line in lines[a - 1 : b]:
            print(line.strip())


# Suppose 'input.txt' is a file in the same directory with content as described in the problem
display_lines("input.txt", 4, 12)
