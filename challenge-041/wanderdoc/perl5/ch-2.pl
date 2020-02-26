#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
Write a script to display first 20 Leonardo Numbers.

a(n) = 2 * Fibonacci(n+1) - 1. - Richard L. Ollerton Mar 22 2002.
https://oeis.org/A001595

First 20 Leonardo numbers (first being No.0):
1, 1, 3, 5, 9, 15, 25, 41, 67, 109, 177, 287, 465, 753, 1219, 1973, 3193, 5167, 8361, 13529, 21891
=cut

# use bigint; # If you will 500 numbers or so :-).

my $fn = shift || 20; #  or die "How much numbers?\n";
print join(" ", map 2 * fib($_ + 1) - 1, 0 .. 20), $/;

=output
1 1 3 5 9 15 25 41 67 109 177 287 465 753 1219 1973 3193 5167 8361 13529 21891
=cut


# Algorithm found at:
# https://stackoverflow.com/questions/494594

sub fib
{
     my $n = shift;
     my $x = 0; 
     my $y = 1;

     my $m = 0; 
     while ( $m < $n )
     {
          ($x, $y) = ($y, $x + $y);
          $m++;

     }

     return $x;
}
