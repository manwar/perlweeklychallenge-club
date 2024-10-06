#!/usr/bin/env python3

# Challenge 165
#
# Task 2: Line of Best Fit
# Submitted by: Ryan J Thompson
#
# When you have a scatter plot of points, a line of best fit is the line that
# best describes the relationship between the points, and is very useful in
# statistics. Otherwise known as linear regression, here is an example of what
# such a line might look like:
#
# Hull
#
# The method most often used is known as the least squares method, as it is
# straightforward and efficient, but you may use any method that generates the
# correct result.
#
# Calculate the line of best fit for the following 48 points:
#
# 333,129  39,189 140,156 292,134 393,52  160,166 362,122  13,193
# 341,104 320,113 109,177 203,152 343,100 225,110  23,186 282,102
# 284,98  205,133 297,114 292,126 339,112 327,79  253,136  61,169
# 128,176 346,72  316,103 124,162  65,181 159,137 212,116 337,86
# 215,136 153,137 390,104 100,180  76,188  77,181  69,195  92,186
# 275,96  250,147  34,174 213,134 186,129 189,154 361,82  363,89

import sys

def svg_header(width, height):
    return f'''<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.0//EN" "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">
<svg height="{height}" width="{width}" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
'''

def svg_footer():
    return '''</svg>
'''

def svg_circle(cx, cy, r):
    return f'<circle cx="{int(cx)}" cy="{int(cy)}" r="{int(r)}" stroke="black" />\n'

def svg_point(cx, cy):
    return svg_circle(cx, cy, 1)

def svg_line(x1, y1, x2, y2):
    return f'<line x1="{int(x1)}" y1="{int(y1)}" x2="{int(x2)}" y2="{int(y2)}" stroke="black" />\n'

def least_squares(points):
    N = len(points)
    sum_x = sum_y = sum_x2 = sum_xy = 0
    for x, y in points:
        sum_x += x
        sum_y += y
        sum_x2 += x * x
        sum_xy += x * y
    m = (N * sum_xy - sum_x * sum_y) / (N * sum_x2 - sum_x * sum_x)
    b = (sum_y - m * sum_x) / N
    return m, b

file = sys.argv[1] if len(sys.argv) > 1 else None
if file is None:
    raise Exception("usage: ch-1.py file.svg")

with open(file, "w") as f:
    f.write(svg_header(500, 500))
    points = []
    for line in sys.stdin:
        for point in line.split():
            x, y = map(int, point.split(','))
            points.append((x, y))
            f.write(svg_point(x, y))
    m, b = least_squares(points)
    f.write(svg_line(0, b, 500, m * 500 + b))
    f.write(svg_footer())
