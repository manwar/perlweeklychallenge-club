#!perl

################################################################################
=comment

Perl Weekly Challenge 223
=========================

TASK #1
-------
*Count Primes*

Submitted by: Mohammad S Anwar

You are given a positive integer, $n.

Write a script to find the total count of primes less than or equal to the given
integer.

Example 1

  Input: $n = 10
  Output: 4

  Since there are 4 primes (2,3,5,7) less than or equal to 10.

Example 2

  Input: $n = 1
  Output: 0

Example 3

  Input: $n = 20
  Output: 8

  Since there are 8 primes (2,3,5,7,11,13,17,19) less than or equal to 20.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Note
----
This is a repeat of Week 198, Task #2: "Prime Count", except that "less than $n"
has been changed to "less than or equal to" $n.

Interface
---------
If no command-line arguments are given, the test suite is run.

=cut
#===============================================================================

use strict;
use warnings;
use Const::Fast;
use Math::Prime::Util qw( prime_count );
use Regexp::Common    qw( number );
use Test::More;

const my $USAGE =>
"Usage:
  perl $0 <n>
  perl $0

    <n>    A positive integer\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 223, Task #1: Count Primes (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
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
        $n > 0 or error( qq["$n" is not positive (greater than zero)] );

        print "Input:  \$n = $n\n";

        my $primes = count_primes( $n );

        print "Output: $primes\n";
    }
    else
    {
        error( "Expected 0 or 1 command-line arguments, found $args");
    }
}

#-------------------------------------------------------------------------------
sub count_primes
#-------------------------------------------------------------------------------
{
    my ($n) = @_;

    return prime_count( $n );
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $n, $expected) = split / \| /x, $line;

        for ($test_name, $n, $expected)                        # Trim whitespace
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $primes = count_primes( $n );

        is $primes, $expected, $test_name;
    }

    done_testing;
}

#-------------------------------------------------------------------------------
sub error
#-------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

################################################################################

__DATA__
Week 223, Example 1|        10|       4
Week 223, Example 2|         1|       0
Week 223, Example 3|        20|       8
Week 198, Example 2|        15|       6
Weel 198, Example 4|        25|       9
Large n            |   1000000|   78498
Huge n             |1234567890|62106578
