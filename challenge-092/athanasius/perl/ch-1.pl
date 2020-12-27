#!perl

###############################################################################
=comment

Perl Weekly Challenge 092
=========================

Task #1
-------
*Isomorphic Strings*

Submitted by: Mohammad S Anwar

You are given two strings $A and $B.

Write a script to check if the given strings are *Isomorphic*
(https://www.educative.io/edpresso/how-to-check-if-two-strings-are-isomorphic).
Print 1 if they are otherwise 0.

Example 1:

 Input: $A = "abc"; $B = "xyz"
 Output: 1

Example 2:

 Input: $A = "abb"; $B = "xyy";
 Output: 1

Example 3:

 Input: $A = "sum"; $B = "add"
 Output: 0

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;
use Set::Scalar;

const my $USAGE =>
"Usage:
  perl $0 <A> <B>

    <A>    First string
    <B>    Second string\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 092, Task #1: Isomorphic Strings (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    scalar @ARGV == 2 or die $USAGE;

    my ($A, $B) = @ARGV;

    print  qq[Input:  \$A = "$A"; \$B = "$B"\n];

    printf   "Output: %d\n", strings_are_isomorphic($A, $B);
}

#------------------------------------------------------------------------------
sub strings_are_isomorphic
#------------------------------------------------------------------------------
{
    my ($A, $B) = @ARGV;
    my  @A      = split //, $A;
    my  @B      = split //, $B;

    return 0 if scalar @A != scalar @B;

    my %map;
    my $set = Set::Scalar->new;

    for my $i (0 .. $#A)
    {
        my $c1 = $A[$i];
        my $c2 = $B[$i];

        if (exists $map{$c1})
        {
            return 0 if $map{$c1} ne $c2;
        }
        else
        {
            return 0 if $set->has($c2);

            $map{$c1} =  $c2;
            $set->insert($c2);
        }
    }

    return 1;
}

###############################################################################
