#!perl

###############################################################################
=comment

Perl Weekly Challenge 173
=========================

TASK #1
-------
*Esthetic Number*

Submitted by: Mohammad S Anwar

You are given a positive integer, $n.

Write a script to find out if the given number is Esthetic Number.


    An esthetic number is a positive integer where every adjacent digit differs
    from its neighbour by 1.


For example,

  5456 is an esthetic number as |5 - 4| = |4 - 5| = |5 - 6| = 1
  120 is not an esthetic number as |1 - 2| != |2 - 0| != 1

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Note on Leading Zeros
---------------------
$n might be input as "0345434", which would fail the esthetic test because
|0 - 3| != 1. But since $n is specified as a positive integer, I have chosen to
interpret "0345434" as 345434, which passes the test.

Algorithm
---------
This is straightforward: test each digit from first to second-last against its
successor: if the absolute value of the difference between them is not 1, $n is
not esthetic; if all digits pass this test, $n is esthetic.

Note that "differs from its neighbour by 1" is a commutative operation, so it
is only necessary to test the digits in one direction.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );

const my $USAGE =>
"Usage:
  perl $0 <n>

    <n>    A positive integer\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 173, Task #1: Esthetic Number (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $n        = parse_command_line();
    my $esthetic = is_esthetic( $n );

    printf "%d is%s an esthetic number\n", $n, $esthetic ? '' : ' not';
}

#------------------------------------------------------------------------------
sub is_esthetic
#------------------------------------------------------------------------------
{
    my ($n)     = @_;
    my  @digits = split //, $n;

    for my $i (0 .. $#digits - 1)
    {
        return 0 unless abs( $digits[ $i ] - $digits[ $i + 1 ] ) == 1;
    }

    return 1;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 1 or error( "Expected 1 command line argument, found $args" );

    my $n = $ARGV[ 0 ];

       $n =~ / ^ $RE{num}{int} $ /x
                  or error( qq[Argument "$n" is not a valid integer] );

       $n >  0    or error( qq[Argument "$n" is not positive] );

       $n += 0;                   # Remove any initial zeros

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
