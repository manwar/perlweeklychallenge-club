#!perl

###############################################################################
=comment

Perl Weekly Challenge 147
=========================

TASK #2
-------
*Pentagon Numbers*

Submitted by: Mohammad S Anwar

Write a script to find the first pair of Pentagon Numbers whose sum and differ-
ence are also a Pentagon Number.

    Pentagon numbers can be defined as P(n) = n(3n - 1)/2.

Example

 The first 10 Pentagon Numbers are:
 1, 5, 12, 22, 35, 51, 70, 92, 117 and 145.

 P(4) + P(7) = 22 + 70 = 92 = P(8)
 but
 P(4) - P(7) = |22 - 70| = 48 is not a Pentagon Number.

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Discussion
----------
Consider a pair J of Pentagon Numbers: J = (P(x), P(y)). If x = y, the differ-
ence P(x) - P(y) = 0, which is not a Pentagon Number. So we require x ≠ y. For
convenience, we specify x < y. Now consider a second pair K = (P(z), P(w))
where z < w. What is required to determine whether J < K?

If x < z AND y < w, it is clear that J < K. But if x < z and y > w, J is
neither greater than nor less than K. In fact, pairs of Pentagon Numbers form a
partially ordered set with a product ordering [1]. Therefore, the term "first
pair" is not well-defined.

For the purposes of this Task I assume that Pentagon Number pairs are ordered,
firstly, by the second (i.e., the larger) of the two Pentagon Numbers, and,
secondly, by the first (smaller) Pentagon Number. This assumption simplifies
the search algorithm since the upper search bound is always known up front.

The minimum value required for $MAX_PENT was found by trial and error.

Reference
---------
[1] https://en.wikipedia.org/wiki/Product_order

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;

const my $MAX_PENT => 2_400;
const my $USAGE    => "Usage:\n  perl $0\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 147, Task #2: Pentagon Numbers (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    parse_command_line();

    print "The first pair of Pentagon Numbers whose\n",
          "sum and difference are also Pentagon Numbers:\n\n";

    my ($pent_h, $pent_a) = populate_pentagonals();            # Hash and array

    L_OUTER:
    for my $i (1 .. $#$pent_a)
    {
        my $pi = $pent_a->[  $i ];
        my $ni = $pent_h->{ $pi };

        for my $j (0 .. $i - 1)
        {
            my $pj  = $pent_a->[  $j ];
            my $nj  = $pent_h->{ $pj };
            my $sum = $pi + $pj;

            if (exists $pent_h->{ $sum })
            {
                my $diff = abs( $pi - $pj );

                if (exists $pent_h->{ $diff })
                {
                    printf "P(%d) + P(%d) =  %d + %d  = %d = P(%d)\n" .
                           "P(%d) - P(%d) = |%d - %d| = %d = P(%d)\n",
                            $nj, $ni, $pj, $pi, $sum,  $pent_h->{ $sum  },
                            $nj, $ni, $pj, $pi, $diff, $pent_h->{ $diff };

                    last L_OUTER;
                }
            }
        }
    }
}

#------------------------------------------------------------------------------
sub populate_pentagonals
#------------------------------------------------------------------------------
{
    my %pent_hash;

    for my $n (1 .. $MAX_PENT)
    {
        my $p = $n * (3 * $n - 1) / 2;

        $pent_hash{ $p } = $n;
    }

    my @pent_array = sort { $a <=> $b } keys %pent_hash;

    return (\%pent_hash, \@pent_array);
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 0 or die "ERROR: Expected 0 command line arguments, found " .
                         "$args\n$USAGE";
}

###############################################################################
