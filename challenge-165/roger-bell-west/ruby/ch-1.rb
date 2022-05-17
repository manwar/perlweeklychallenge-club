#! /usr/bin/ruby

points = []
lines = []
x = []
y = []

while line = gets
  f = line.chomp.split(",").collect { |i| i.to_i }
  f.each_with_index do |v,i|
    if i % 2 == 0 then
      x.push(v)
    else
      y.push(v)
    end
  end
  if f.length == 4 then
    lines.push(f)
  elsif f.length == 2 then
    points.push(f)
  end
end

mnx = x.min
mxx = x.max
mny = y.min
mxy = y.max

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

print('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>' + "\n")
print('<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.0//EN" "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">' + "\n")
print("<svg width=\"#{w}\" height=\"#{h}\" viewBox=\"#{lo[0]} #{lo[1]} #{w} #{w}\" xmlns=\"http://www.w3.org/2000/svg\" xmlns:svg=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\">\n")

if lines.length > 0 then
  print("  <g id=\"lines\" stroke=\"#369\" stroke-width=\"4\">\n")
  lines.each do |p|
    print("    <line x1=\"#{p[0]}\" y1=\"#{p[1]}\" x2=\"#{p[2]}\" y2=\"#{p[3]}\" />\n")
  end
  print("  </g>\n")
end

if points.length > 0 then
  print("  <g fill=\"#f73\" id=\"points\">\n")
  points.each do |p|
    print("    <circle cx=\"#{p[0]}\" cy=\"#{p[1]}\" r=\"3\" />\n")
  end
  print("  </g>\n")
end

print("</svg>\n")
