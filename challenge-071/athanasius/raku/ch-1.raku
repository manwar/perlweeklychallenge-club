use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 071
=========================

Task #1
-------
*Peak Element*

*Submitted by:* Mohammad S Anwar

You are given positive integer _$N_ (>1).

Write a script to create an array of size _$N_ with random unique elements
between _1_ and _50_.

In the end it should print _peak elements_ in the array, if found.

    An array element is called peak if it is bigger than its neighbour[s].

*Example 1*

Array: [ 18, 45, 38, 25, 10, 7, 21, 6, 28, 48 ]
Peak:  [ 48, 45, 21 ]

*Example 2*

Array: [ 47, 11, 32, 8, 1, 9, 39, 14, 36, 23 ]
Peak:  [ 47, 32, 39, 36 ]

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

my UInt constant $MAX = 50;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 071, Task #1: Peak Element (Raku)\n".put;
}

#===============================================================================
sub MAIN
(
    #| Array size: N is an integer such that 1 < N <= MAX

    UInt:D $N where { $N > 1 && $N <= $MAX }
)
#===============================================================================
{
    # Method pick() of class List: "Returns $count elements chosen at random and
    # without repetition from the invocant."

    my UInt @array = (1 .. $MAX).pick: $N;
    my UInt @peaks =  find-peaks(@array);

    "Array: [ %s ]\n".printf: @array.join: ', ';
    "Peak:  [ %s ]\n".printf: @peaks.join: ', ';
}

#-------------------------------------------------------------------------------
sub find-peaks
(
    Array:D[UInt:D] $array
--> Array:D[UInt:D]
)
#-------------------------------------------------------------------------------
{
    my UInt @peaks;

    @peaks.push: $array[0] if $array[0] > $array[1];            # First element

    for 1 .. $array.elems - 2 -> UInt $i                 # Intermediate elements
    {
        @peaks.push: $array[$i] if $array[$i] > $array[$i - 1] &&
                                   $array[$i] > $array[$i + 1];
    }

    @peaks.push: $array[*-1] if $array[*-1] > $array[*-2];      # Final element

    return @peaks;
}

#-------------------------------------------------------------------------------
sub USAGE()
#-------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;
    $usage ~~ s/ MAX /$MAX/;
    $usage.put;
}

################################################################################
