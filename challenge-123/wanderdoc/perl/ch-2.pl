#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given coordinates of four points i.e. (x1, y1), (x2, y2), (x3, y3) and (x4, y4).
Write a script to find out if the given four points form a square.
=cut










use Struct::Dumb;
struct Point => [qw( x y )];

sub check_square
{
     my @points = @_;
     my %distances;

     for my $i ( 0 .. 3 ) 
     {
          for my $j ( 1 .. 3 )
          {
               next if $i >= $j;
               $distances{$i}{$j} = calc_distance(@points[$i, $j]);
               return 0 if 0 == $distances{$i}{$j};
          }
     } 

     return 1 
     if


     (
          ($distances{0}{1} == $distances{0}{2} and $distances{0}{3} == 2 * $distances{0}{1} and $distances{0}{1} == $distances{2}{3})
               or
          ($distances{0}{1} == $distances{0}{3} and $distances{0}{2} == 2 * $distances{0}{1} and $distances{0}{1} == $distances{2}{3})
               or
          ($distances{1}{2} == $distances{1}{3} and $distances{0}{1} == 2 * $distances{1}{2} and $distances{1}{2} == $distances{0}{3})
     );
     return 0;

}

sub calc_distance # distance _squared_.
{
     my @pts = @_;
     return   (($pts[0]->x - $pts[1]->x) * ($pts[0]->x - $pts[1]->x) + 
               ($pts[0]->y - $pts[1]->y) * ($pts[0]->y - $pts[1]->y));
}


print check_square(Point(10, 20), Point(20, 20), Point(20, 10), Point(10, 10)), $/; # 1
print check_square(Point(12, 24), Point(16, 10), Point(20, 12), Point(18, 16)), $/; # 0
print check_square(Point(10, 30), Point(20, 10), Point(30, 40), Point(40, 20)), $/; # 1
print check_square(Point(-2, -1), Point(-2,  2), Point( 1, -1), Point( 1,  2)), $/; # 1
print check_square(Point(10, 10), Point(10, 20), Point(30, 10), Point(30, 20)), $/; # 0