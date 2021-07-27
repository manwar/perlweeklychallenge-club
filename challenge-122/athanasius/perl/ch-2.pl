#!perl

###############################################################################
=comment

Perl Weekly Challenge 122
=========================

TASK #2
-------
*Basketball Points*

Submitted by: Mohammad S Anwar

You are given a score $S.

You can win basketball points e.g. 1 point, 2 points and 3 points.

Write a script to find out the different ways you can score $S.

Example

 Input: $S = 4
 Output: 1 1 1 1
         1 1 2
         1 2 1
         1 3
         2 1 1
         2 2
         3 1

 Input: $S = 5
 Output: 1 1 1 1 1
         1 1 1 2
         1 1 2 1
         1 1 3
         1 2 1 1
         1 2 2
         1 3 1
         2 1 1 1
         2 1 2
         2 2 1
         2 3
         3 1 1
         3 2

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Algorithm
---------
1. Construct all possible combinations:
   1a. For each multiple of 2 (including 0) <= S, add in 1s as needed to bring
       the digit sum up to S
   1b. For each non-zero multiple of 3 <= S, add in 1s and 2s as per 1a to
       bring the digit sum up to S
2. Find the distinct permutations of each combination
   -- the algorithm is described below at sub get_next_permutation()
3. Sort the permutations in ascending lexicographical order
   -- compare strings formed by concatenating the elements of each permutation
4. Display the results

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );

const my $USAGE =>
"Usage:
  perl $0 <S>

    <S>    A basketball score\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 122, Task #2: Basketball Points (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $S = parse_command_line();

    print "Input:  \$S = $S\n";

    my @perms;

    # 1. Construct all possible combinations

    for my $comb (get_combinations( $S ))
    {
        # 2. Find the distinct permutations of each combination

        do
        {
            push @perms, [ @$comb ];    # Make a copy

        } while ($comb = get_next_permutation( $comb ));
    }

    # 3. Sort the permutations in ascending lexicographical order

    @perms = sort { join( '', @$a ) cmp join( '', @$b ) } @perms;

    # 4. Display the results

    if (@perms && @{ $perms[ 0 ] })
    {
        printf "Output: %s\n",  join ' ', @{ shift @perms };
        printf "        %s\n",  join ' ', @$_  for @perms;
    }
    else
    {
        print  "Output: <none>\n";
    }
}

#------------------------------------------------------------------------------
sub get_combinations
#------------------------------------------------------------------------------
{
    my ($S)    = @_;
    my  @combs = fill_with_2s( $S );          # Includes zero 2s (i.e., all 1s)

    for my $threes (1 .. int( $S / 3 ))
    {
        for my $partition (fill_with_2s( $S - 3 * $threes ))
        {
            push @combs, [ @$partition, (3) x $threes ];
        }
    }

    return @combs;
}

#------------------------------------------------------------------------------
sub fill_with_2s
#------------------------------------------------------------------------------
{
    my ($s) = @_;
    my  @partitions;

    for my $twos (0 .. int( $s / 2 ))
    {
        push @partitions, [ (1) x ($s - 2 * $twos), (2) x $twos ];
    }

    return @partitions;
}

#------------------------------------------------------------------------------
# Algorithm adapted from:
#   https://en.wikipedia.org/wiki/Permutation#Generation_in_lexicographic_order
#
#  "The following algorithm generates the next permutation lexicographically
#   after a given permutation. It changes the given permutation in-place."
#
sub get_next_permutation
#------------------------------------------------------------------------------
{
    my ($comb) = @_;

    # 1. "Find the largest index k such that a[k] < a[k + 1]. If no such index
    #     exists, the permutation is the last permutation."

    my $k;

    for my $i (0 .. $#$comb - 1)
    {
        $k = $i if $comb->[ $i ] < $comb->[ $i + 1 ];
    }

    return unless defined $k;

    # 2. "Find the largest index l greater than k such that a[k] < a[l]."

    my $l;

    for my $i ($k + 1 .. $#$comb)
    {
        $l = $i if $comb->[ $k ] < $comb->[ $i ];
    }

    # 3. "Swap the value of a[k] with that of a[l]."

    ($comb->[ $k ], $comb->[ $l ]) = ($comb->[ $l ], $comb->[ $k ]);

    # 4. "Reverse the sequence from a[k + 1] up to and including the final
    #     element a[n]."

    return [ 
                       @{ $comb }[ 0      .. $k      ],
               reverse @{ $comb }[ $k + 1 .. $#$comb ]
           ];
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 1 or error( "Expected 1 command line argument, found $args" );

    my $S = $ARGV[ 0 ] + 0;    # Normalize

       $S =~ / ^ $RE{num}{int} $ /x
                  or error( qq["$S" is not a valid integer] );

       $S >= 0    or error( qq["$S" is negative] );

    return $S;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
