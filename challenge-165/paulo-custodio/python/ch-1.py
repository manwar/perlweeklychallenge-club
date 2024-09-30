#!/usr/bin/env python3

# Challenge 165
#
# Task 1: Scalable Vector Graphics (SVG)
# Submitted by: Ryan J Thompson
#
# Scalable Vector Graphics (SVG) are not made of pixels, but lines, ellipses,
# and curves, that can be scaled to any size without any loss of quality. If you
# have ever tried to resize a small JPG or PNG, you know what I mean by "loss of
# quality"! What many people do not know about SVG files is, they are simply XML
# files, so they can easily be generated programmatically.
#
# For this task, you may use external library, such as Perl's SVG library,
# maintained in recent years by our very own Mohammad S Anwar. You can instead
# generate the XML yourself; it's actually quite simple. The source for the
# example image for Task #2 might be instructive.
#
# Your task is to accept a series of points and lines in the following format,
# one per line, in arbitrary order:
#
# Point: x,y
#
# Line: x1,y1,x2,y2
# Example:
#
# 53,10
# 53,10,23,30
# 23,30
#
# Then, generate an SVG file plotting all points, and all lines. If done
# correctly, you can view the output .svg file in your browser.

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
