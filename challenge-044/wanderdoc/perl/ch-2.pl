#!perl

use strict;
use warnings FATAL => qw(all);

=promt

You have only $1 left at the start of the week. You have been given an opportunity to make it $200. The rule is simple with every move you can either double what you have or add another $1. Write a script to help you get $200 with the smallest number of moves.

=cut

=theory

Doubling the value makes it faster than adding 1. The decision: dividing 200 back until an odd number comes, then substract 1.

=cut

my $GOAL = 200;
my $START = $GOAL;

my @steps;

while ( $START >= 1 )
{
     push @steps, [$START, $GOAL];
     if ( $START % 2 == 0 )
     {
          $START /= 2;
     }
     else
     {
          $START -= 1;
     }
}

print join("\t", qw(Step Start Goal)), $/;

my $counter = 0;
for my $step ( reverse @steps )
{
     print join("\t", $counter, @$step[0,1] ), $/;
     $counter++;
}
