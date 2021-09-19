#!perl

###############################################################################
=comment

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

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );

const my $USAGE =>
"Usage:
  perl $0 [<N> ...]

    [<N> ...]    List of +ve ints: exactly 1 appears an odd number of times\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 130, Task #1: Odd Number (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my @N = parse_command_line();

    printf "Input:  \@N = (%s)\n", join ', ', @N;

    my %dict;
     ++$dict{ $_ } for @N;

    my %odd;

    while (my ($key, $value) = each %dict)
    {
        $odd{ $key } = $value if $value % 2 == 1;
    }

    my $count = scalar keys %odd;

    if    ($count == 0)
    {
        error( 'No entries appear an odd number of times' );
    }
    elsif ($count == 1)
    {
         printf "Output: %s\n", (keys %odd)[ 0 ];
    }
    else
    {
        error( "$count entries appear an odd number of times" );
    }
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    for (@ARGV)
    {
        / ^ $RE{num}{int} $ /x
            or error( qq["$_" is not a valid integer] );

        $_ >= 0
            or error( qq["$_" is not a positive integer] );
    }

    return @ARGV;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "\nERROR: $message\n$USAGE";
}

###############################################################################
