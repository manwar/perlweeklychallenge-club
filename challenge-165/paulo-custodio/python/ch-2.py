#!/usr/bin/env python3

# Perl Weekly Challenge 165 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-165/

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
