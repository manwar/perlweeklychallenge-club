#!perl

###############################################################################
=comment

Perl Weekly Challenge 177
=========================

TASK #1
-------
*Damm Algorithm*

Submitted by: Mohammad S Anwar

You are given a positive number, $n.

Write a script to validate the given number against the included check digit.

Please checkout the [ https://en.wikipedia.org/wiki/Damm_algorithm |wikipedia
page] for information.

Example 1

  Input: $n = 5724
  Output: 1 as it is valid number

Example 2

  Input: $n = 5727
  Output: 0 as it is invalid number

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Configuration
-------------
If $VERBOSE is set to a true value, the output includes an explanation which
either confirms that the check digit is correct or shows what the check digit
should be.

Algorithm
---------
Both the generation and the validation of a check digit proceed by traversing
the given operation table as follows [1, "Algorithm"]:

    1. $interim_digit := 0
    2. FOR each $digit in $n, from the most- to the least-significant
           $interim_digit := the value in the operation table corresponding
                             to row $digit and column $interim_digit
       ENDFOR
    3. $result := $interim_digit

- To generate a check digit: $n is the number for which the check digit is
  required; and $result is the required check digit.
- To validate a check digit: $n is the number to be validated *including its
  check digit* (which is always the final digit). The check digit is valid if
  and only if $result is 0.

Reference
---------
[1] "Damm algorithm", Wikipedia, https://en.wikipedia.org/wiki/Damm_algorithm

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );

const my @OP_TABLE =>
(
    [ 0, 3, 1, 7, 5, 9, 8, 6, 4, 2 ],
    [ 7, 0, 9, 2, 1, 5, 4, 8, 6, 3 ],
    [ 4, 2, 0, 6, 8, 7, 1, 3, 5, 9 ],
    [ 1, 7, 5, 0, 9, 8, 3, 4, 2, 6 ],
    [ 6, 1, 2, 3, 0, 4, 5, 9, 7, 8 ],
    [ 3, 6, 7, 4, 2, 0, 9, 5, 8, 1 ],
    [ 5, 8, 6, 9, 7, 2, 0, 1, 3, 4 ],
    [ 8, 9, 4, 5, 3, 6, 2, 0, 1, 7 ],
    [ 9, 4, 3, 8, 6, 1, 7, 2, 0, 5 ],
    [ 2, 5, 8, 1, 4, 3, 6, 7, 9, 0 ],
);

const my $USAGE =>
"Usage:
  perl $0 <n>

    <n>    A positive integer of at least 2 digits\n";

const my $VERBOSE => 1;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 177, Task #1: Damm Algorithm (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $n      = parse_command_line();
    my $spaces = $VERBOSE ? '     ' : '';

    printf "Input:  %s\$n = %d\n", $spaces, $n;

    my $valid  = check_digit( $n ) == 0 ? 1 : 0;

    printf "Output: %s%d\n",       $spaces, $valid;

    explain( $n, $valid ) if $VERBOSE;
}

#------------------------------------------------------------------------------
sub check_digit
#------------------------------------------------------------------------------
{
    my ($number)       = @_;
    my  $interim_digit = 0;

    for my $digit (split //, $number)
    {
        $interim_digit = $OP_TABLE[ $interim_digit ][ $digit ];
    }

    return $interim_digit;
}

#------------------------------------------------------------------------------
sub explain
#------------------------------------------------------------------------------
{
    my ($n, $valid)  = @_;
    my  $check_digit = substr $n, -1, 1;

    printf qq[Explanation: The check digit "%d" is %scorrect],
           $check_digit, $valid ? '' : 'in';

    printf qq[; it should be "%d"],
           check_digit( substr $n, 0, length( $n ) - 1 ) unless $valid;

    print "\n";
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 1 or error( "Expected 1 command line argument, found $args" );

    my $n = $ARGV[ 0 ];

    $n =~ / ^ $RE{num}{int} $ /x
                  or error( qq["$n" is not a valid integer] );

    $n >= 0       or error( qq["$n" is not positive] );
    $n >  9       or error( qq["$n" has only one digit] );

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
