#!perl

###############################################################################
=comment

Perl Weekly Challenge 140
=========================

TASK #1
-------
*Add Binary*

Submitted by: Mohammad S Anwar

You are given two decimal-coded binary numbers, $a and $b.

Write a script to simulate the addition of the given binary numbers.

    The script should simulate something like $a + $b. (operator overloading)

Example 1

  Input: $a = 11; $b = 1;
  Output: 100

Example 2

  Input: $a = 101; $b = 1;
  Output: 110

Example 3

  Input: $a = 100; $b = 11;
  Output: 111

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Assumptions
-----------
- "Decimal-coded binary numbers" are just binary numbers
- These binary numbers are restricted to non-negative integers
- Leading zeros are allowed, but will be trimmed

Solution
--------
The file BinUInt.pm contains the implementation of BinUInt, a class which
comprises a constructor and two overloaded operators: stringification (trivial)
and addition. The latter performs binary addition using the same logic that a
human would use to add two binary numbers together manually.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Try::Tiny;
use lib qw( . );
use BinUInt;

const my $USAGE =>
"Usage:
  perl $0 <a> <b>

    <a>    A non-negative integer in binary
    <b>    A non-negative integer in binary\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 140, Task #1: Add Binary (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my  $args = scalar @ARGV;
        $args == 2
            or error( "Expected 2 command line arguments, found $args\n" );

    my ($a_str, $b_str) = @ARGV;
    my ($a_obj, $b_obj);

    try
    {
        $a_obj = BinUInt->new( $a_str );
        $b_obj = BinUInt->new( $b_str );
    }
    catch
    {
        error( $_ );
    };

    print "Input:  \$a = $a_obj; \$b = $b_obj\n";

    my $sum_obj = $a_obj + $b_obj;                   # Use operator overloading

    print "Output: $sum_obj\n";
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message$USAGE";
}

###############################################################################
