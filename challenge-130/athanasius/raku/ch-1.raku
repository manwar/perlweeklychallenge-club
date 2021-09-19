use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 130
=========================

TASK #1
-------
*Odd Number*

Submitted by: Mohammad S Anwar

You are given an array of positive integers, such that all the numbers appear
even number of times except one number.

Write a script to find that integer.

Example 1

 Input: @N = (2, 5, 4, 4, 5, 5, 2)
 Output: 5 as it appears 3 times in the array where as all other numbers 2 and
         4 appears exactly twice.

Example 2

 Input: @N = (1, 2, 3, 4, 3, 2, 1, 4, 4)
 Output: 4

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 130, Task #1: Odd Number (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    *@N where { .all ~~ UInt:D }    #= List of +ve ints: exactly one appears an
                                    #= odd number of times
)
#==============================================================================
{
    "Input:  @N = (%s)\n".printf: @N.join: ', ';

    my UInt %dict;
          ++%dict{ $_ } for @N;

    my UInt %odd = %dict<>:p.grep: { .value % 2 == 1 };

    given %odd.elems
    {
        when 0
        {
            error( 'No entries appear an odd number of times' );
        }

        when 1
        {
            "Output: { %odd<>:k }".put;
        }

        default
        {
            error( %odd.elems ~ ' entries appear an odd number of times' );
        }
    }
}

#------------------------------------------------------------------------------
sub error( Str:D $message )
#------------------------------------------------------------------------------
{
    "\nERROR: $message".put;

    USAGE();

    exit;
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
