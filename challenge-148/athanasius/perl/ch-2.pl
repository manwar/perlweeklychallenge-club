#!perl

###############################################################################
=comment

Perl Weekly Challenge 148
=========================

TASK #2
-------
*Cardano Triplets*

Submitted by: Mohammad S Anwar

Write a script to generate first 5 Cardano Triplets.

    A triplet of positive integers (a,b,c) is called a Cardano Triplet if it
    satisfies the below condition.

    ∛(a + b√c) + ∛(a - b√c) = 1

Example

 (2,1,5) is the first Cardano Triplets.

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Notes
-----
1. As with Week 147, Task 2: Pentagon Numbers, the notion of a "first" triplet
   is not well-defined, because triplets form a partially-ordered set. For the
   purposes of this Task, I (arbitrarily) assume that, for triplets A = (a,b,c)
   and X = (x,y,z), A < X iff: a < x
                            OR a = x AND b < y
                            OR a = x AND b = y AND c < z.

2. For a discussion of the complexities surrounding the derivation of cube
   roots in Perl, see my PerlMonks thread "How to get better exponentiation?"
   at https://www.perlmonks.com/index.pl?node_id=11140698

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use POSIX qw( cbrt ); # See https://www.perlmonks.com/index.pl?node_id=11140700

const my $EPSILON => 1e-15;
const my $MAX_X   => 11;
const my $MAX_Y   =>  4;
const my $MAX_Z   => 52;
const my $TARGET  =>  5;
const my $USAGE   => "Usage:\n  perl $0\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 148, Task #2: Cardano Triplets (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;
       $args == 0 or die 'ERROR: Expected 0 command line arguments, found ' .
                         "$args\n$USAGE";

    print "The first $TARGET Cardano Triplets:\n";

    my $count = 0;

    L_OUTER:
    for my $x (1 .. $MAX_X)
    {
        for my $y (1 .. $MAX_Y)
        {
            for my $z (1 .. $MAX_Z)
            {
                if (is_cardano_triplet( $x, $y, $z ))
                {
                    printf "    (%2d, %d, %2d)\n", $x, $y, $z;

                    last L_OUTER if ++$count >= $TARGET;
                }
            }
        }
    }
}

#------------------------------------------------------------------------------
sub is_cardano_triplet                            # ∛(x + y√z) + ∛(x - y√z) = 1
#------------------------------------------------------------------------------
{
    my ($x, $y, $z) = @_;

    my $term = $y * sqrt( $z );
    my $lhs  = cbrt( $x + $term );
    my $rhs  = cbrt( $x - $term );

    return abs( $lhs + $rhs - 1 ) < $EPSILON;
}

###############################################################################
