use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 182
=========================

TASK #1
-------
*Max Index*

Submitted by: Mohammad S Anwar

You are given a list of integers.

Write a script to find the index of the first biggest number in the list.

Example

  Input: @n = (5, 2, 9, 1, 7, 6)
  Output: 2 (as 3rd element in the list is the biggest number)


  Input: @n = (4, 2, 3, 1, 5, 0)
  Output: 4 (as 5th element in the list is the biggest number)

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Configuration
-------------
Set the constant $VERBOSE to True to add an explanation to the output, as per
the Examples.

=end comment
#==============================================================================

my Bool constant $VERBOSE = True;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 182, Task #1: Max Index (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    *@n where { .elems > 0 && .all ~~ Int:D }   #= A non-empty list of integers
)
#==============================================================================
{
    "Input:  @n = (%s)\n".printf: @n.join: ', ';

    my Int  $max = @n.max;
    my UInt $index;

    for 0 .. @n.end -> UInt $i
    {
        if @n[ $i ] == $max
        {
            $index = $i;
            last;
        }
    }

    if $VERBOSE
    {
        "Output: %d (as %d, the %s element in the list, is the largest)\n".\
            printf: $index, $max, ordinal( $index + 1 );
    }
    else
    {
        "Output: $index".put;
    }
}

#------------------------------------------------------------------------------
sub ordinal( UInt:D $n --> Str:D )
#------------------------------------------------------------------------------
{
    my UInt $ones   =  $n % 10;
    my UInt $tens   = ($n / 10).floor % 10;
    my Str  $suffix =  $tens == 1 ?? 'th' !!
                       $ones == 1 ?? 'st' !!
                       $ones == 2 ?? 'nd' !!
                       $ones == 3 ?? 'rd' !! 'th';

    return $n ~ $suffix;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

###############################################################################
