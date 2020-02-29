#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
Write a script to accept a positive number as command line argument and print the smallest multiple of the given number consists of digits 0 and 1.
For example: For given number 55, the smallest multiple is 110 consisting of digits 0 and 1.
=cut






=notes
For now: Solution with brute force. Works, however there are several cases where it takes too long.
I will try to implement the pidgeonhole algorithmus seen here: https://math.stackexchange.com/questions/83932 .
=cut


use Math::BigInt;
Math::BigInt->accuracy(30);
use Time::HiRes qw[ time ];



my $NUM = shift or die "Which number?\n"; 
my $start = time;

my $FLAG_2_5 = ($NUM % 2 == 0 or $NUM % 5 == 0) ? 1 : 0;

for my $i (1  .. 1_000_000_000)
{
     my $multiple = sprintf("%b", $i);
     if ( $FLAG_2_5 == 1 and substr($multiple, -1, 1) eq '1' ) {next; }

     if ( length($multiple) > 17 )
     {


          my $x = Math::BigInt->new($multiple);
          my $modulo = $x->bmod($NUM);
          if (0 == $modulo)
          {
               print $multiple, $/; last;
          }
     }


     else
     {
          if ( 0 == $multiple % $NUM )
          {
               print $multiple, $/; last;
          }
     }
}

print "Used time: ", time() - $start, $/;