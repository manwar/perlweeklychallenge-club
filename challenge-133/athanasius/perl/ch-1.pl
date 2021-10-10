#!perl

###############################################################################
=comment

Perl Weekly Challenge 133
=========================

TASK #1
-------
*Integer Square Root*

Submitted by: Mohammad S Anwar

You are given a positive integer $N.

Write a script to calculate the integer square root of the given number.

Please avoid using built-in function. Find out more about it
[ https://en.wikipedia.org/wiki/Integer_square_root |here].

Examples

 Input: $N = 10
 Output: 3

 Input: $N = 27
 Output: 5

 Input: $N = 85
 Output: 9

 Input: $N = 101
 Output: 10

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Algorithm
---------
The solution is found using both Newton's method (aka Heron's method) and the
digit-by-digit algorithm (recursive version) described in the Wikipedia article
cited in the Task Description.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );

const my $DBL_LOG_2 => 1.386_294_361_119_890_618_834_464_242_916_4;
const my $USAGE     =>
"Usage:
  perl $0 <N>

    <N>    A positive integer\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 133, Task #1: Integer Square Root (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $N = parse_command_line();

    print  "Input:  \$N = $N\n";
    printf "Output: %d (Newton's method)\n",          int_sqrt_newton( $N );
    printf "        %d (digit-by-digit algorithm)\n", int_sqrt_digit ( $N );
}

#------------------------------------------------------------------------------
sub int_sqrt_newton
#------------------------------------------------------------------------------
{
    my ($n) = @_;

    # x0 = 2^(⎣log2(n) / 2⎦ + 1) gives a good starting value for x0 (see
    # https://en.wikipedia.org/wiki/Integer_square_root#Numerical_example); but
    # x0 = ($n / 2) + 1 is an acceptable (and simpler) alternative :-)

    my  $x0 = 2 ** (int( log($n) / $DBL_LOG_2) + 1);
    my  $x1 = ($x0 + ($n / $x0)) / 2;

    while ($x1 < $x0)
    {
        $x0 =  $x1;
        $x1 = ($x0 + ($n / $x0)) / 2;
    }

    return $x0;
}

#------------------------------------------------------------------------------
sub int_sqrt_digit                                         # Recursive function
#------------------------------------------------------------------------------
{
    my ($n) = @_;

    return $n if $n < 2;

    my $small_cand = 2 * int_sqrt_digit( int( $n / 4 ) );
    my $large_cand = $small_cand + 1;

    return ($large_cand * $large_cand > $n) ? $small_cand : $large_cand;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 1
            or error( "Expected 1 command line argument, found $args" );

    my $N = $ARGV[ 0 ];

    $N =~ / ^ $RE{num}{int} $ /x
        or error( qq["$N" is not a valid integer] );

    $N > 0
        or error( qq["$N" is not a positive integer] );

    return $N;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
