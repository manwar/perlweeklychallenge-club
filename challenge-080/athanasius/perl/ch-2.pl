#!perl

###############################################################################
=comment

Perl Weekly Challenge 080
=========================

Task #2
-------
*Count Candies*

Submitted by: Mohammad S Anwar

You are given rankings of @N candidates.

Write a script to find out the total candies needed for all candidates. You are
asked to follow the rules below:

a) You must given at least one candy to each candidate.
b) Candidate with higher ranking get more candies than their immediate neigh-
   bors on either side.

Example 1:

 Input: @N = (1, 2, 2)

Explanation:

 Applying rule #a, each candidate will get one candy. So total candies needed
 so far 3. Now applying rule #b, the first candidate do not get any more candy
 as its rank is lower than it's neighbours. The second candidate gets one more
 candy as it's ranking is higher than it's neighbour. Finally the third candi-
 date do not get any extra candy as it's ranking is not higher than neighbour.
 Therefore total candies required is 4.

 Output: 4

Example 2:

 Input: @N = (1, 4, 3, 2)

Explanation:

 Applying rule #a, each candidate will get one candy. So total candies needed
 so far 4. Now applying rule #b, the first candidate do not get any more candy
 as its rank is lower than it's neighbours. The second candidate gets two more
 candies as it's ranking is higher than it's both neighbour. The third candi-
 date gets one more candy as it's ranking is higher than it's neighbour. Final-
 ly the fourth candidate do not get any extra candy as it's ranking is not
 higher than neighbour. Therefore total candies required is 7.

 Output: 7

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

                                       # Exports:
use strict;
use warnings;
use Const::Fast;                       # const()
use List::Util     qw( sum0 );
use Regexp::Common qw( number );       # %RE{num}

#------------------------------------------------------------------------------
# Constants
#------------------------------------------------------------------------------

use constant
{
    CHECK_RULE_B      => 1,
    SHOW_DISTRIBUTION => 1,
};

const my $USAGE =>
"Usage:
  perl $0 [<N> ...]

    [<N> ...]    A list of candidate rankings (numeric)\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 080, Task #2: Count Candies (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my @N = @ARGV;
    /\A$RE{num}{real}\z/ or die "ERROR: Non-numeric '$_'\n$USAGE" for @N;

    my @candies = (1) x scalar @N;                    # Apply Rule (a)

    1 while distribute_candies(\@N, \@candies);       # Apply Rule (b) until it
                                                      #   produces no changes
    if (CHECK_RULE_B)
    {
        satisfies_b(\@N, \@candies)
            or die 'ERROR: The solution breaks Rule (b), stopped';
    }

    printf "Input: \@N = (%s)\n", join ', ', @N;
    printf "Candies:    (%s)\n",  join ', ', @candies if SHOW_DISTRIBUTION;

    printf "Total candies needed: %d\n", sum0 @candies;
}

#------------------------------------------------------------------------------
sub distribute_candies
#------------------------------------------------------------------------------
{
    my ($N, $C)  = @_;
    my  $changed = 0;

    for my $i (0 .. $#$N - 1)                    # (1) Distribute left-to-right
    {
        my $j = $i + 1;

        if ($N->[$i] > $N->[$j] && $C->[$i] <= $C->[$j])
        {
            $C->[$i] = $C->[$j] + 1;
            $changed = 1;
        }
    }

    for my $i (reverse 1 .. $#$N)                # (2) Distribute right-to-left
    {
        my $j = $i - 1;

        if ($N->[$i] > $N->[$j] && $C->[$i] <= $C->[$j])
        {
            $C->[$i] = $C->[$j] + 1;
            $changed = 1;
        }
    }

    return $changed;
}

if (CHECK_RULE_B)
{
    #--------------------------------------------------------------------------
    sub satisfies_b
    #--------------------------------------------------------------------------
    {
        my ($N, $C) = @_;

        for my $i (0 .. $#$N - 1)            # (1) Check Rule (b) left-to-right
        {
            if ($N->[$i] > $N->[$i + 1])
            {
                $C->[$i] > $C->[$i + 1] or return 0;
            }
        }

        for my $i (reverse 1 .. $#$N)        # (2) Check Rule (b) right-to-left
        {
            if ($N->[$i] > $N->[$i - 1])
            {
                $C->[$i] > $C->[$i - 1] or return 0;
            }
        }

        return 1;
    }
}

###############################################################################
