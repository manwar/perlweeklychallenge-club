#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
Write a script to display attractive number between 1 and 50.
    A number is an attractive number if the number of its prime factors is also prime number.
=cut






my $N = shift || 50; # or die "How much is the number?\n";

for ( 1 .. $N ) 
{ 
     print_attractive($_); 
}

=output
4 = 2 * 2
6 = 2 * 3
8 = 2 * 2 * 2
9 = 3 * 3
10 = 2 * 5
12 = 2 * 2 * 3
14 = 2 * 7
15 = 3 * 5
18 = 2 * 3 * 3
20 = 2 * 2 * 5
21 = 3 * 7
22 = 2 * 11
25 = 5 * 5
26 = 2 * 13
27 = 3 * 3 * 3
28 = 2 * 2 * 7
30 = 2 * 3 * 5
32 = 2 * 2 * 2 * 2 * 2
33 = 3 * 11
34 = 2 * 17
35 = 5 * 7
38 = 2 * 19
39 = 3 * 13
42 = 2 * 3 * 7
44 = 2 * 2 * 11
45 = 3 * 3 * 5
46 = 2 * 23
48 = 2 * 2 * 2 * 2 * 3
49 = 7 * 7
50 = 2 * 5 * 5
=cut

sub print_attractive
{
     my $n = $_[0];

     my $n_orig = $n;
     my $counter = 0;

     my @factors;

     # Old nice one-liner for prime factorization:
     # perl -le "$x = shift; for $k (2 .. $x/2) {$x%$k or (print $k and $x /= $k and redo) }"


     for my $k ( 2 .. $n/2 )
     {
          0 == $n % $k and
               $factors[$counter++] = $k and
               $n /= $k and redo;
     }
     print join(" ", $n_orig, '=', join(' * ',@factors)), $/ if is_prime($counter);
}


# https://en.wikipedia.org/wiki/Primality_test

sub is_prime
{
     my $n = $_[0];
     if ($n <= 3) {return $n > 1 ? 1 : 0;}
     elsif (0 == $n % 2 or 0 == $n % 3) {return 0;}

     else
     {
          my $i = 5;
          while ( $i * $i <= $n )
          {
               if ( 0 == $n % $i or 0 == $n % ($i + 2))
               {
                    return 0;
               }
               $i += 6; 
          }
     }
    return 1;
}