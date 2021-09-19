#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of positive integers, such that all the numbers appear even number of times except one number.
Write a script to find that integer.
=cut








sub find_odd
{
     my @arr = @_;
     my $max = 0;
     my $str = '';
     for my $num ( @arr )
     {
          vec($str, $num, 1) = vec($str, $num, 1) == 1 ? 0 : 1;
          $max = $num > $max ? $num: $max;

     }
     my @output;
     for my $i ( 0 .. $max )
     {
          push @output, $i if vec($str, $i, 1) == 1;
     }
     return @output;
}

print join(" ", find_odd(2, 5, 4, 4, 5, 5, 2)), $/; # 5
print join(" ", find_odd(1, 2, 3, 4, 3, 2, 1, 4, 4)), $/; # 4