#! /usr/bin/python3

import fileinput

points = []
lines = []

x = []
y = []

for line in fileinput.input():
  line=line.rstrip()
  f = [int(i) for i in line.split(',')]
  for i in range(len(f)):
    if i % 2 == 0:
      x.append(f[i])
    else:
      y.append(f[i])
  if len(f) == 4:
    lines.append(f)
  if len(f) == 2:
    points.append(f)

mnx = min(x)
mxx = max(x)

mny = min(y)
mxy = max(y)

lo = [
  mnx - (mxx-mnx)/10,
  mny - (mxy-mny)/10
]
hi = [
  mxx + (mxx-mnx)/10,
  mxy + (mxy-mny)/10
]

w = hi[0] - lo[0]
h = hi[1] - lo[1]

print('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>')
print('<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.0//EN" "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">')
print(f'<svg width="{w}" height="{h}" viewBox="{lo[0]} {lo[1]} {w} {h}" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">')

if len(lines) > 0:
  print('  <g id="lines" stroke="#369" stroke-width="4">')
  for p in lines:
    print(f'    <line x1="{p[0]}" y1="{p[1]}" x2="{p[2]}" y2="{p[3]}" />')
  print('  </g>')


if len(points) > 0:
  print('  <g fill="#f73" id="points">')
  for p in points:
    print(f'    <circle cx="{p[0]}" cy="{p[1]}" r="3" />')
  print('  </g>')

print('</svg>')
