use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 122
=========================

TASK #1
-------
*Average of Stream*

Submitted by: Mohammad S Anwar

You are given a stream of numbers, @N.

Write a script to print the average of the stream at every point.

Example

 Input: @N = (10, 20, 30, 40, 50, 60, 70, 80, 90, ...)
 Output:      10, 15, 20, 25, 30, 35, 40, 45, 50, ...

 Average of first number is 10.
 Average of first 2 numbers (10+20)/2 = 15
 Average of first 3 numbers (10+20+30)/3 = 20
 Average of first 4 numbers (10+20+30+40)/4 = 25 and so on.

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

my Bool constant $VERBOSE = True;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 122, Task #1: Average of Stream (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    *@N where { .all ~~ Real:D }                         #= A stream of numbers
)
#==============================================================================
{
    "Input: @N = (%s)\n".printf: @N.join: ', ';
    'Output:      '.print;

    my Real $sum   = 0;
    my UInt $count = 0;

    for @N
    {
        $sum += $_;

        my Real $average = $sum / ++$count;

        ', '.print if $count > 1;
        $average.print;
    }

    put();
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
