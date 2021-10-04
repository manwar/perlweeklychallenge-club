#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-1.rb < input-file
#

def div (x, y)
    return (x . to_f / y) . to_i
end

def g2j (y, m, d)
    return (div(1461 * (y +    4800 + div(m - 14, 12)),   4) +
            div( 367 * (m - 2 -   12 * div(m - 14, 12)),  12) -
            div(   3 * div(y +  4900 + div(m - 14, 12), 100), 4) + d - 32075)
end

def j2g (j)
    e = 4 * (j + 1401 + div(div(4 * j + 274277, 146097) * 3, 4) - 38) + 3;
    d =   div((5 * div(e % 1461, 4) + 2) % 153, 5) + 1;
    m = ((div( 5 * div(e % 1461, 4) + 2, 153) + 2) % 12) + 1;
    y =            div(e,  1461) - 4716 + div(12 + 2 - m, 12);
    return y, m, d
end

julian_today = g2j 2021, 9, 22

ARGF . each_line do
    | line |
    y, m, d = line . strip . split("/") . map {|x| x . to_i}
    julian_then = g2j y, m, d
    puts "%04d/%02d/%02d, %04d/%02d/%02d\n" %
         [j2g(2 * julian_then  - julian_today),
          j2g(2 * julian_today - julian_then)] . flatten
end
