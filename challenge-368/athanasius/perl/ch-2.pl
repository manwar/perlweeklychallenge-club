#!perl

################################################################################
=comment

Perl Weekly Challenge 368
=========================

TASK #2
-------
*Big and Little Omega*

Submitted by: Roger Bell_West

You are given a positive integer $number and a mode flag $mode. If the mode flag
is zero, calculate little omega (the count of all distinct prime factors of that
number). If it is one, calculate big omega (the count of all prime factors
including duplicates).

Example 1

  Input: $number = 100061
         $mode = 0
  Output: 3

  Prime factors are 13, 43, 179. Count is 3.

Example 2

  Input: $number = 971088
         $mode = 0
  Output: 3

  Prime factors are 2, 2, 2, 2, 3, 20231. Count of distinct numbers is 3.

Example 3

  Input: $number = 63640
         $mode = 1
  Output: 6

  Prime factors are 2, 2, 2, 5, 37, 43. Count including duplicates is 6.

Example 4

  Input: $number = 988841
         $mode = 1
  Output: 2

Example 5

  Input: $number = 211529
         $mode = 0
  Output: 2

=cut
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A positive integer is entered on the command-line, followed by a string which
   is either "0" or "1".
3. If the constant $VERBOSE is set to a true value, the output count is followed
   by a list of the input number's prime factors.

=cut
#===============================================================================

use v5.38.2;      # Enables strictures
use warnings;
use Const::Fast;
use List::Util        qw( uniqint );
use Math::Prime::Util qw( factor );
use Regexp::Common    qw( number );
use Test::More;

const my $VERBOSE => 1;
const my $USAGE   => <<END;
Usage:
  perl $0 <number> <mode>
  perl $0

    <number>    A positive integer
    <mode>      A mode string, either "0" or "1"
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 368, Task #2: Big and Little Omega (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $argc = scalar @ARGV;

    if    ($argc == 0)
    {
        run_tests();
    }
    elsif ($argc == 2)
    {
        my ($number, $mode) = @ARGV;

        $number =~ / ^ $RE{num}{int} $ /x
                    or error( qq["$number" is not a valid integer] );

        $number > 0 or error( "$number is not positive" );

        $mode eq '0' || $mode eq '1'
                    or error( qq[Unrecognised mode "$mode"] );

        print "Input:  \$number = $number\n";
        print "        \$mode   = $mode\n";

        my ($count, $factors) = count_prime_factors( $number, $mode );

        print "Output: $count\n";

        printf( "\nPrime factors: %s\n", join ', ', @$factors ) if $VERBOSE;
    }
    else
    {
        error( "Expected 0 or 2 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub count_prime_factors
#-------------------------------------------------------------------------------
{
    my ($number, $mode) = @_;

    my @factors = factor( $number );

    my $count = ($mode == 0) ? scalar uniqint @factors      # Little omega
                             : scalar @factors;             # Big    omega

    return ($count, \@factors);
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    say 'Running the test suite';

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $number, $mode, $exp_count, $exp_factors_str) =
             split / \| /x, $line;

        for ($test_name, $number, $mode, $exp_count, $exp_factors_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my ($count, $factors) = count_prime_factors( $number, $mode );
        my  @exp_factors      = split / \s+ /x, $exp_factors_str;

        is        $count,    $exp_count,   "$test_name: count";
        is_deeply $factors, \@exp_factors, "$test_name: factors";
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
Example 1|100061|0|3|13 43 179
Example 2|971088|0|3|2 2 2 2 3 20231
Example 3| 63640|1|6|2 2 2 5 37 43
Example 4|988841|1|2|7 141263
Example 5|211529|0|2|37 5717
