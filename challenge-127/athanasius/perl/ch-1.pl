#!perl

###############################################################################
=comment

Perl Weekly Challenge 127
=========================

TASK #1
-------
*Disjoint Sets*

Submitted by: Mohammad S Anwar

You are given two sets with unique integers.

Write a script to figure out if they are disjoint.

    The two sets are disjoint if they don't have any common members.

Example

 Input: @S1 = (1, 2, 5, 3, 4)
        @S2 = (4, 6, 7, 8, 9)
 Output: 0 as the given two sets have common member 4.

 Input: @S1 = (1, 3, 5, 7, 9)
        @S2 = (0, 2, 4, 6, 8)
 Output: 1 as the given two sets do not have common member.

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Note
----
Input set elements are verified as integers, but no check is made for dupli-
cates as these are automatically removed during set creation.

Algorithm
---------
Set intersection using the CPAN module Set::Scalar.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Set::Scalar;

const my $USAGE =>
qq[Usage:
  perl $0 <S1> <S2>

    <S1>    Set 1: a string of the form "( int-a, int-b, ... )"
    <S2>    Set 2: a string of the form "( int-m, int-n, ... )"\n];

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 127, Task #1: Disjoint Sets (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my ($S1, $S2) = parse_command_line();

    printf "Input:  \@S1 = (%s)\n", join ', ', @$S1;
    printf "        \@S1 = (%s)\n", join ', ', @$S2;

    my $set1  = Set::Scalar->new( @$S1 );
    my $set2  = Set::Scalar->new( @$S2 );
    my $inter = $set1 * $set2;                               # Set intersection

    if ($inter->is_empty)
    {
        print  'Output: 1 (disjoint) as the given two sets do not have any ' .
               "common members\n";
    }
    else
    {
        printf 'Output: 0 (not disjoint) as the given two sets have the ' .
               "common member%s %s\n",
                    scalar $inter->elements == 1 ? '' : 's',
                    join ', ', sort { $a <=> $b } $inter->elements;
    }
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 2 or error( "Expected 2 command line arguments, found $args" );

    my @array;

    for my $i (0, 1)
    {
        my $S = $ARGV[ $i ];
           $S =~ / ^ \( (.*) \) $ /x
                  or error( qq[Malformed string "$S"] );

        for (split / , \s* /x, $1)
        {
            / ^ $RE{num}{int} $ /x
                  or error( qq["$_" is not a valid integer] );

            push @{ $array[ $i ] }, $_;
        }
    }

    return @array;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
