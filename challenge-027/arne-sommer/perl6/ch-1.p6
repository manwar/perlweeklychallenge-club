#! /usr/bin/env perl6

# Wikipedia: "line segment intersection"
# "Finding the intersection point of two line segments in R2"


# unit sub MAIN (Numeric $a, Numeric $b, Numeric $c, Numeric $d,
#               Numeric $p, Numeric $q, Numeric $r, Numeric $s);

unit sub MAIN (Numeric \x1, Numeric \y1, Numeric \x2, Numeric \y2,
               Numeric \x3, Numeric \y3, Numeric \x4, Numeric \y4);




# https://www.geeksforgeeks.org/check-if-two-given-line-segments-intersect/
# https://rosettacode.org/wiki/Find_the_intersection_of_two_lines#Perl_6
# http://www.cs.swan.ac.uk/~cssimon/line_intersection.html

my \ta1 = (y3−y4) * (x1−x3) + (x4−x3) * (y1−y3);
my \ta2 = (x4−x3) * (y1−y2) − (x1−x2) * (y4−y3);

my \tb1 = (y1−y2) * (x1−x3) + (x2−x1) * (y1−y3);
my \tb2 = (x4−x3) * (y1−y2) − (x1−x2) * (y4−y3);

my \ta = ta1 / ta2;
my \tb = tb1 / tb2;

if ta2 == 0 || tb2 == 0
{
  say "Colinear lines";
}
elsif 0 <= ta <= 1 && 0 <= tb <= 1
{
  say "Segment intersection at x: { x1 + ta * (x2 - x1) } y: { y1 + ta * (y2 − y1) }";
}
else
{
  say "General Intersection (outside the box)";
}

