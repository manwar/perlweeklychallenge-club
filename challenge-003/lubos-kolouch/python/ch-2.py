#!/usr/bin/env python
# -*- coding: utf-8 -*-

def generate_pascal_triangle(rows):
    triangle = []
    for i in range(rows):
        row = [1]
        for j in range(1, i):
            row.append(triangle[i-1][j-1] + triangle[i-1][j])
        if i > 0:
            row.append(1)
        triangle.append(row)
    return triangle

rows = int(input("Enter the number of rows to generate: "))
if rows < 3:
    print("Error: Pascal's Triangle must have at least 3 rows")
else:
    triangle = generate_pascal_triangle(rows)
    print(f"Pascal's Triangle with {rows} rows:")
    for i in range(rows):
        padding = " " * (rows-i-1)
        print(padding + " ".join(map(str, triangle[i])))
