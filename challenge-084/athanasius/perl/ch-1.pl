#!perl

###############################################################################
=comment

Perl Weekly Challenge 084
=========================

Task #1
-------
*Reverse Integer*

Submitted by: Mohammad S Anwar

You are given an integer $N.

Write a script to reverse the given integer and print the result. Print 0 if
the result doesn't fit in 32-bit signed integer.

The number 2,147,483,647 is the maximum positive value for a 32-bit signed
binary integer in computing.

Example 1:

 Input: 1234
 Output: 4321

Example 2:

 Input: -1234
 Output: -4321

Example 3:

 Input: 1231230512
 Output: 0

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

                                       # Exports:
use strict;
use warnings;
use Const::Fast;                       # const()
use Regexp::Common qw( number );       # %RE{num}

const my $MAX   =>  (2 ** 31) - 1;
const my $MIN   => -(2 ** 31);
const my $USAGE =>
"Usage:
  perl $0 <N>

    <N>    An integer to be reversed\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 084, Task #1: Reverse Integer (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $N = parse_command_line();

    print "Input:  $N\n";

    my $reverse = reverse abs $N;

    if ($N < 0)
    {
        $reverse *= -1;
        $reverse  =  0 if $reverse < $MIN;
    }
    else
    {
        $reverse  =  0 if $reverse > $MAX;
    }

    print "Output: $reverse\n";
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;

    scalar @ARGV == 1
            or die "ERROR: Expected a single command-line argument, found " .
                   "$args\n$USAGE";

    my $N =  $ARGV[0];
       $N =~ / \A $RE{num}{int} \z /x
            or die "ERROR: \"$N\" is not an integer\n$USAGE";

    return int $N;
}

###############################################################################
