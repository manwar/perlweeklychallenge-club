#!perl

###############################################################################
=comment

Perl Weekly Challenge 135
=========================

TASK #1
-------
*Middle 3-digits*

Submitted by: Mohammad S Anwar

You are given an integer.

Write a script find out the middle 3-digits of the given integer, if possible
otherwise throw sensible error.

Example 1

  Input: $n = 1234567
  Output: 345

Example 2

  Input: $n = -123
  Output: 123

Example 3

  Input: $n = 1
  Output: too short

Example 4

  Input: $n = 10
  Output: even number of digits

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
  perl $0 <n>

    <n>    An integer of d digits where d is odd at least 3\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 135, Task #1: Middle 3-digits (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $n = parse_command_line();

    print "Input:  \$n = $n\n";

    my $digits = length abs $n;

    if    ($digits % 2 == 0)
    {
        print "Output: \$n has an even number of digits\n";
    }
    elsif ($digits < 3)
    {
        print "Output: \$n has too few digits\n";
    }
    else   # Valid $n
    {
        my @digits  = split '', abs $n;
        my $mid_idx = (($digits - 1) / 2);

        printf "Output: %s%s%s\n", @digits[ $mid_idx - 1 .. $mid_idx + 1 ];
    }
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 1
            or error( "Expected 1 command line argument, found $args" );

    my $n = $ARGV[ 0 ];
       $n =~ / ^ $RE{num}{int} $ /x
            or error( qq["$_" is not a valid integer] );

    return $n;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
