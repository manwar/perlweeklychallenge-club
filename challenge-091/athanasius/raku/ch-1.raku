use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 091
=========================

Task #1
-------
*Count Number*

Submitted by: Mohammad S Anwar

You are given a positive number $N.

Write a script to count number and display as you read it.

Example 1:

 Input: $N = 1122234
 Output: 21321314

 as we read "two 1 three 2 one 3 one 4"

Example 2:

 Input: $N = 2333445
 Output: 12332415

 as we read "one 2 three 3 two 4 one 5"

Example 3:

 Input: $N = 12345
 Output: 1112131415

 as we read "one 1 one 2 one 3 one 4 one 5"

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 091, Task #1: Count Number (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    Int:D $N where { $N > 0 }              #= A positive integer
)
#==============================================================================
{
    "Input:  \$N = $N".put;
    'Output: '.print;

    my UInt @digits     = $N.split('', :skip-empty).map: { .Int };
    my UInt $last-digit = @digits.shift;
    my UInt $count      = 1;

    while @digits.elems
    {
        my UInt $next-digit = @digits.shift;

        if $next-digit == $last-digit
        {
            ++$count;
        }
        else
        {
            "$count$last-digit".print;

            $last-digit = $next-digit;
            $count      = 1;
        }
    }

    "$count$last-digit".put;
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
