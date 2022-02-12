#!perl

###############################################################################
=comment

Perl Weekly Challenge 151
=========================

TASK #2
-------
*Rob The House*

Submitted by: Mohammad S Anwar

You are planning to rob a row of houses, always starting with the first and
moving in the same direction. However, you can’t rob two adjacent houses.

Write a script to find the highest possible gain that can be achieved.

Example 1:

 Input: @valuables = (2, 4, 5);
 Output: 7

 If we rob house (index=0) we get 2 and then the only house we can rob is house
 (index=2) where we have 5.
 So the total valuables in this case is (2 + 5) = 7.

Example 2:

 Input: @valuables = (4, 2, 3, 6, 5, 3);
 Output: 13

 The best choice would be to first rob house (index=0) then rob house (index=3)
 then finally house (index=5).
 This would give us 4 + 6 + 3 = 13.

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Output
------
If $VERBOSE is set to a true value (the default), the output is followed by an
explanation showing the indices of the houses robbed, together with the sum of
their values.

Assumptions
-----------
1. All house values are numbers greater than zero (i.e., every house is worth
   robbing).
2. All house values are integers. (But note: if real values were to be allowed,
   this would not affect the algorithm.)

Steps
-----
Let the distance between houses be the difference of their indices. Since ad-
jacent houses (where the distance is 1) cannot be robbed, the minimum distance
between successive houses to rob is 2.

Now consider a distance of 4. If, e.g., houses are a, b, c, d, e, then the dis-
tance from a to e is 4; but c could be robbed between a and e, without affect-
ing the algorithm from e onwards; and by assumption 1, robbing c will increase
the total gain. So a step of 4 is always inferior to 2 consecutive steps of 2.

A similar argument holds for steps of 5 and above. So, step distances are lim-
ited to just 2 and 3.

Algorithm
---------
Note that the first house is always the first to be robbed, from which it fol-
lows that the second house - which is adjacent to the first - is never robbed.

1. Each house is assigned a zero sum. (This "sum" will eventually represent the
   maximum cumulative gain from robbing houses up to and including this house.)
2. The 3rd & 4th houses (indices 2 & 3) are initialised by assigning sums equal
   to their own value plus the value of house 1 (index 0). This is the gain
   from robbing house 1 followed by a step of 2 (house 3), and a step of 3
   (house 4).
3. Beginning with house 3 (index 2), and continuing until the 3rd last house,
   steps of 2 and 3 are computed and the resulting cumulative gains compared
   with the maximum already stored at the destination house. If the newly-com-
   puted step results in a larger gain than the sum stored at the destination,
   that sum is updated with the new maximum. In this way, when each house is
   reached in this (step 3) traversal, the maximum gain to be made by robbing
   houses up to this house has already been recorded against that house.
4. When the 3rd-last house has been processed, the sums for the remaining 2
   houses - the 2nd-last and the last - are compared. The larger sum is the
   solution.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );

const my $VERBOSE => 1;
const my $USAGE   =>
"Usage:
  perl $0 [<valubles> ...]

    [<valubles> ...]    Positive integers: values of valubles\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 151, Task #2: Rob The House (Perl)\n\n";
}

#==============================================================================
package House
#==============================================================================
{
    use Class::Tiny qw( value sum path );
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $values     = parse_command_line();
    my $num_houses = scalar @$values;

    printf "Input:  \@valuables = (%s)\n", join ', ', @$values;

    my $best_sum  = $values->[ 0 ];               # First value
    my $best_path = [ 0 ];                        # House indices

    ($best_sum, $best_path) = find_best_path( $values ) if $num_houses > 2;
    
    print "Output: $best_sum\n";

    if ($VERBOSE)
    {
        if ($num_houses <= 2)
        {
            print  "\nRobbing house 0 yields $best_sum\n";
        }
        else
        {
            printf "\nRobbing houses (%s) yields (%s) = %d\n",
                    join( ', ',  @$best_path ),
                    join( ' + ', @$values[ @$best_path ] ), $best_sum;
        }
    }
}

#------------------------------------------------------------------------------
sub find_best_path
#------------------------------------------------------------------------------
{
    my ($values) = @_;
    my  @houses  = init_houses( $values );

    for my $i (2 .. $#$values - 2)
    {
        for my $j ($i + 2, $i + 3)
        {
            if ($j <= $#$values)
            {
                my  $new_sum = $houses[ $i ]->sum +
                               $houses[ $j ]->value;

                if ($new_sum > $houses[ $j ]->sum)
                {
                    $houses[ $j ]->sum( $new_sum );
                    $houses[ $j ]->path( [ $houses[ $i ]->path->@*, $j ] );
                }
            }
        }
    }

    my $best_i = $houses[ -2 ]->sum >=
                 $houses[ -1 ]->sum ? -2 : -1;

    return ($houses[ $best_i ]->sum,
            $houses[ $best_i ]->path);
}

#------------------------------------------------------------------------------
sub init_houses
#------------------------------------------------------------------------------
{
    my  ($values) = @_;
    my   @houses;
    push @houses, House->new( value => $_, sum => 0, path => [] ) for @$values;

    for my $i (2, 3)
    {
        if ($i <= $#$values)
        {
            $houses[ $i ]->sum( $houses[ 0  ]->value +
                                $houses[ $i ]->value );

            $houses[ $i ]->path( [ 0, $i ] );
        }
    }

    return @houses;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    scalar @ARGV > 0           or error( 'Expected at least one command ' .
                                         'line argument, found none' );

    my @valubles = @ARGV;

    for (@valubles)
    {
        / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] );

        $_ > 0                 or error( qq["$_" is not positive] );
    }

    return \@valubles;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
