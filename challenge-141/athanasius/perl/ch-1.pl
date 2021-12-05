#!perl

###############################################################################
=comment

Perl Weekly Challenge 141
=========================

TASK #1
-------
*Number Divisors*

Submitted by: Mohammad S Anwar

Write a script to find lowest 10 positive integers having exactly 8 divisors.

Example

 24 is the first such number having exactly 8 divisors.
 1, 2, 3, 4, 6, 8, 12 and 24.

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Configuration
-------------
- Set $VERBOSE to a true value to show the divisors of each integer in the
  solution
- $DIVISORS is configurable; e.g., $DIVISORS = 2 generates the prime numbers!

Algorithm
---------
1. Divisors come in pairs: if i is a divisor of n then j = n / i is also a
   divisor of n
2. If i = j then i = sqrt(n)

So, to find all the divisors of n by searching, it's only necessary to search
the range 1 to sqrt(n):

    divisors := empty
    FOR d in range 1 to ⌊sqrt(n)⌋
        IF d is a divisor of n THEN
            Add d to divisors
            d1 := n / d
            IF d < d1
                Add d1 to divisors
            ENDIF
        ENDIF
    ENDFOR
    sort divisors ascending

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;

const my $VERBOSE  =>  1;
const my $DIVISORS =>  8;
const my $TARGET   => 10;
const my $USAGE    => "Usage:\n  perl $0\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 141, Task #1: Number Divisors (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;
       $args == 0 or die 'ERROR: Expected 0 command line arguments, found ' .
                         "$args\n$USAGE";

    printf "The lowest %d positive integers having exactly %d divisors:\n",
            $TARGET, $DIVISORS;

    for (my ($first, $n, $count) = (1, 1, 0); $count < $TARGET; ++$n)
    {
        my @divisors = find_divisors( $n );

        if (scalar @divisors == $DIVISORS)
        {
            if ($VERBOSE)
            {
                printf "    %2d (%s )\n", $n,
                       join ', ', map { sprintf '%2d', $_ } @divisors;
            }
            else
            {
                printf '%s%d', $first ? '    ' : ', ', $n;
            }

            $first = 0;
            ++$count;
        }
    }

    print "\n" unless $VERBOSE;
}

#------------------------------------------------------------------------------
sub find_divisors
#------------------------------------------------------------------------------
{
    my ($n) = @_;
    my  @div;

    for my $d (1 .. int sqrt $n)
    {
        if ($n % $d == 0)
        {
            push @div, $d;

            my $d1 = $n / $d;

            push @div, $d1 if $d < $d1;
        }
    }

    return sort { $a <=> $b } @div;
}

###############################################################################
