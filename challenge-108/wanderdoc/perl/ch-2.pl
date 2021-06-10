#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
Write a script to display top 10 Bell Numbers.
=cut



my @triangle;
push @triangle, [1];

my @bell_numbers = (1, 1);
for my $i ( 1 .. 20 )
{
     my @arr;
     $arr[0] = $triangle[0][-1];
     for my $j ( 1 .. $i )
     {
          $arr[$j] = $arr[$j - 1] + $triangle[0][$j - 1];
     }
     push @triangle, [@arr];

     $bell_numbers[$i] = $triangle[0][-1];

     shift @triangle; # We need two "lines" only.
}

print join(": ", $_, $bell_numbers[$_]), $/ for 0 .. $#bell_numbers;