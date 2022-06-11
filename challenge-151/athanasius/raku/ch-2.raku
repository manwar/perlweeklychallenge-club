use v6d;

###############################################################################
=begin comment

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

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Output
------
If $VERBOSE is set to True (the default), the output is followed by an explana-
tion showing the indices of the houses robbed, together with the sum of their
values.

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

=end comment
#==============================================================================

my Bool constant $VERBOSE = True;

subset Pos of Int where * > 0;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 151, Task #2: Rob The House (Raku)\n".put;
}

#==============================================================================
class House
#==============================================================================
{
    has Pos         $.value;
    has UInt        $.sum  is rw;
    has Array[UInt] $.path is rw;
}

#==============================================================================
sub MAIN
(
    *@valubles where { .all ~~ Pos:D && .elems > 0 }      #= Positive integers: 
                                                          #= values of valubles
)
#==============================================================================
{
    my Pos $num-houses = +@valubles;

    "Input:  @valuables = ({ @valubles.join: ', ' })".put;

    my Pos         $best-sum  = @valubles[ 0 ];                 # First value
    my Array[UInt] $best-path = Array[UInt].new: 0;             # House indices

    ($best-sum, $best-path) = find-best-path( @valubles ) if $num-houses > 2;

    "Output: $best-sum".put;

    if $VERBOSE
    {
        if $num-houses <= 2
        {
            "\nRobbing house 0 yields $best-sum".put;
        }
        else
        {
            "\nRobbing houses (%s) yields (%s) = %d\n".printf:
                $best-path.join( ', ' ),
                @valubles[ @$best-path ].join( ' + ' ),
                $best-sum;
        }
    }
}

#------------------------------------------------------------------------------
sub find-best-path( Array:D[Pos:D] $values --> List:D[Pos:D, Array:D[UInt:D]] )
#------------------------------------------------------------------------------
{
    my House @houses = init-houses( $values );

    for 2 .. $values.end - 2 -> UInt $i
    {
        for $i + 2, $i + 3 -> UInt $j
        {
            if $j <= $values.end
            {
                my Pos $new-sum = @houses[ $i ].sum +
                                  @houses[ $j ].value;

                if $new-sum > @houses[ $j ].sum
                {
                    @houses[ $j ].sum  = $new-sum;
                    @houses[ $j ].path = @houses[ $i ].path;
                    @houses[ $j ].path.push: $j;
                }
            }
        }
    }

    my UInt $best-i = @houses[ *-2 ].sum >=
                      @houses[ *-1 ].sum ?? @houses.end - 1 !! @houses.end;

    return @houses[ $best-i ].sum,
           @houses[ $best-i ].path;
}

#------------------------------------------------------------------------------
sub init-houses( Array:D[Pos:D] $values --> Array:D[House:D] )
#------------------------------------------------------------------------------
{
    my House @houses;

    @houses.push: House.new: value => $_, sum => 0, path => Array[UInt].new
        for @$values;

    for 2, 3 -> UInt $i
    {
        if $i <= $values.end
        {
            @houses[ $i ].sum  = @houses[ 0  ].value +
                                 @houses[ $i ].value;

            @houses[ $i ].path.push: 0, $i;
        }
    }

    return @houses;
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
