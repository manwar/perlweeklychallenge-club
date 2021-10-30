#!perl

###############################################################################
=comment

Perl Weekly Challenge 136
=========================

TASK #1
-------
*Two Friendly*

Submitted by: Mohammad S Anwar

You are given 2 positive numbers, $m and $n.

Write a script to find out if the given two numbers are Two Friendly.

    Two positive numbers, m and n are two friendly when gcd(m, n) = 2 ^ p where
    p > 0. The greatest common divisor (gcd) of a set of numbers is the largest
    positive number that divides all the numbers in the set without remainder.

Example 1

    Input: $m = 8, $n = 24
    Output: 1

    Reason: gcd(8,24) = 8 => 2 ^ 3

Example 2

    Input: $m = 26, $n = 39
    Output: 0

    Reason: gcd(26,39) = 13

Example 3

    Input: $m = 4, $n = 10
    Output: 1

    Reason: gcd(4,10) = 2 => 2 ^ 1

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Interface
---------
Include the flag "--verbose" (or just "-v") on the command line to display an
explanation of the output.

Implementation
--------------
Calculation of the greatest common divisor is delegated to the gcd() subroutine
in the ntheory (aka Math::Prime::Util) module.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Getopt::Long;
use ntheory        qw( gcd );
use Regexp::Common qw( number );

const my $USAGE =>
"Usage:
  perl $0 [--verbose|-v] <m> <n>

    --verbose    Explain the output?
    <m>          An integer > 0
    <n>          An integer > 0\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 136, Task #1: Two Friendly (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my ($verbose, $m, $n) = parse_command_line();

    print "Input:  \$m = $m, \$n = $n\n";

    my $friendly = 0;
    my $reason   = 'not a power of 2';
    my $gcd      = gcd( $m, $n );

    if ($gcd == 1)
    {
        $reason = '2 ^ 0';
    }
    else
    {
        my $log2 = int( (log( $gcd ) / log( 2 )) + 0.5 );

        if ($gcd == 2 ** $log2)
        {
            $friendly = 1;
            $reason   = "2 ^ $log2";
        }
    }

    printf "Output: %d\n", $friendly ? 1 : 0;

    print "\nReason: gcd($m, $n) = $gcd which is $reason\n" if $verbose;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $verbose = 0;

    GetOptions( verbose => \$verbose )
               or error( 'Invalid command line flag' );

    my $args = scalar @ARGV;
       $args == 2
               or error( "Expected 2 command line arguments, found $args" );

    my ($m, $n) = @ARGV;

    for ($m, $n)
    {
        / ^ $RE{num}{int} $ /x
               or error( qq["$_" is not a valid integer] );

        $_ > 0 or error( qq["$_" is not greater than zero] );
    }

    return ($verbose, $m, $n);
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
