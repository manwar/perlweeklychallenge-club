use v6d;

###############################################################################
=begin comment

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

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Notes
-----
1. As with Week 147, Task 2: Pentagon Numbers, the notion of a "first" triplet
   is not well-defined, because triplets form a partially-ordered set. For the
   purposes of this Task, I (arbitrarily) assume that, for triplets A = (a,b,c)
   and X = (x,y,z), A < X iff: a < x
                            OR a = x AND b < y
                            OR a = x AND b = y AND c < z.

2. For a discussion of the complexities surrounding the derivation of cube
   roots in Perl (and, by extension, in Raku), see my PerlMonks thread "How to
   get better exponentiation?" at
   https://www.perlmonks.com/index.pl?node_id=11140698

=end comment
#==============================================================================

my Real constant $EPSILON = 1e-15;
my UInt constant $MAX-X   = 11;
my UInt constant $MAX-Y   =  4;
my UInt constant $MAX-Z   = 52;
my UInt constant $TARGET  =  5;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 148, Task #2: Cardano Triplets (Raku)\n".put;
}

#==============================================================================
sub MAIN()
#==============================================================================
{
    "The first $TARGET Cardano Triplets:".put;

    my UInt $count = 0;

    L-OUTER:
    for 1 .. $MAX-X -> UInt $x
    {
        for 1 .. $MAX-Y -> UInt $y
        {
            for 1 .. $MAX-Z -> UInt $z
            {
                if is-cardano-triplet( $x, $y, $z )
                {
                    "    (%2d, %d, %2d)\n".printf: $x, $y, $z;

                    last L-OUTER if ++$count >= $TARGET;
                }
            }
        }
    }
}

#------------------------------------------------------------------------------
sub is-cardano-triplet( UInt:D $x, UInt:D $y, UInt:D $z --> Bool:D )
#------------------------------------------------------------------------------
{
    # ∛(x + y√z) + ∛(x - y√z) = 1

    my Real $term = $y * sqrt( $z );
    my Real $lhs  = cube-root( $x + $term );
    my Real $rhs  = cube-root( $x - $term );

    return ($lhs + $rhs - 1).abs < $EPSILON;
}

#------------------------------------------------------------------------------
sub cube-root( Real:D $n --> Real:D )
#------------------------------------------------------------------------------
{
    return ($n.abs ** (1 / 3)) * ($n < 0 ?? -1 !! 1);
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

##############################################################################
