#!/usr/bin/env python3

# Perl Weekly Challenge 165 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-165/

def svg_header(width, height):
    return f'''<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.0//EN" "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">
<svg height="{height}" width="{width}" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
'''

def svg_footer():
    return '''</svg>
'''

def svg_circle(cx, cy, r):
    return f'<circle cx="{cx}" cy="{cy}" r="{r}" stroke="black" />\n'

def svg_point(cx, cy):
    return svg_circle(cx, cy, 1)

def svg_line(x1, y1, x2, y2):
    return f'<line x1="{x1}" y1="{y1}" x2="{x2}" y2="{y2}" stroke="black" />\n'

import sys

file = sys.argv[1] if len(sys.argv) > 1 else None
if file is None:
    raise Exception("usage: ch-1.py file.svg")

with open(file, "w") as f:
    f.write(svg_header(100, 100))
    for line in sys.stdin:
        line = line.strip()
        p = line.split(',')
        p = [int(coord.strip()) for coord in p]
        if len(p) == 2:
            f.write(svg_point(*p))
        elif len(p) == 4:
            f.write(svg_line(*p))
        else:
            raise Exception(f"cannot parse: {line}")
    f.write(svg_footer())
