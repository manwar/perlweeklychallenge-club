#!perl

###############################################################################
=comment

Perl Weekly Challenge 192
=========================

TASK #1
-------
*Binary Flip*

Submitted by: Mohammad S Anwar

You are given a positive integer, $n.

Write a script to find the binary flip.

Example 1

  Input: $n = 5
  Output: 2

  First find the binary equivalent of the given integer, 101.
  Then flip the binary digits 0 -> 1 and 1 -> 0 and we get 010.
  So Binary 010 => Decimal 2.

Example 2

  Input: $n = 4
  Output: 3

  Decimal 4 = Binary 100
  Flip 0 -> 1 and 1 -> 0, we get 011.
  Binary 011 = Decimal 3

Example 3

  Input: $n = 6
  Output: 1

  Decimal 6 = Binary 110
  Flip 0 -> 1 and 1 -> 0, we get 001.
  Binary 001 = Decimal 1

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Interface
---------
If no command-line arguments are given, the test suite is run.

Assumption
----------
A "positive integer" is a non-negative integer (i.e., one greater than or equal
to zero).

Solution
--------
1. sprintf '%b' translates the integer to its corresponding binary string.
2. The transliteration operator tr/// flips the digits in the binary string.
3. Conversion of the flipped binary string to a decimal integer is accomplished
   by prepending '0b' to the string and then calling Perl's oct function.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $TST_FLDS => 3;
const my $USAGE    =>
"Usage:
  perl $0 <n>
  perl $0

    <n>    A positive integer\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 192, Task #1: Binary Flip (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;

    if    ($args == 0)
    {
        run_tests();
    }
    elsif ($args == 1)
    {
        my $n = $ARGV[ 0 ];

        $n =~ / ^ $RE{num}{int} $ /x
                or error( qq["$n" is not a valid integer] );

        $n >= 0 or error( qq["$n" is not positive] );

        print  "Input:  \$n = $n\n";
        printf "Output: %d\n", binary_flip( $n );
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $args" );
    }
}

#------------------------------------------------------------------------------
sub binary_flip
#------------------------------------------------------------------------------
{
    my ($n)      = @_;
    my  $binary  = sprintf '%b', $n;
    my  $flipped = $binary =~ tr/01/10/r;

    return oct "0b$flipped";
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

#------------------------------------------------------------------------------
sub run_tests
#------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my ($test_name, $n, $expected) = split / , \s* /x, $line, $TST_FLDS;

        is binary_flip( $n ), $expected, $test_name;
    }

    done_testing;
}

###############################################################################

__DATA__
Example 1,     5,   2
Example 2,     4,   3
Example 3,     6,   1
Power of 2,  128, 127
Alternating, 170,  85
Two and one, 438,  73
