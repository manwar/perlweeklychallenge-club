#!perl

################################################################################
=comment

Perl Weekly Challenge 359
=========================

TASK #1
-------
*Digital Root*

Submitted by: Mohammad Sajid Anwar

You are given a positive integer, $int.

Write a function that calculates the additive persistence of a positive integer
and also return the digital root.

    Digital root is the recursive sum of all digits in a number until a single
    digit is obtained.

    Additive persistence is the number of times you need to sum the digits to
    reach a single digit.

Example 1

  Input: $int = 38
  Output: Persistence  = 2
          Digital Root = 2

  38 => 3 + 8 => 11
  11 => 1 + 1 => 2

Example 2

  Input: $int = 7
  Output: Persistence  = 0
          Digital Root = 7

Example 3

  Input: $int = 999
  Output: Persistence  = 2
          Digital Root = 9

  999 => 9 + 9 + 9 => 27
  27  => 2 + 7 => 9

Example 4

  Input: $int = 1999999999
  Output: Persistence  = 3
          Digital Root = 1

  1999999999 => 1 + 9 + 9 + 9 + 9 + 9 + 9 + 9 + 9 + 9 => 82
  82 => 8 + 2 => 10
  10 => 1 + 0 => 1

Example 5

  Input: $int = 101010
  Output: Persistence  = 1
          Digital Root = 3

  101010 => 1 + 0 + 1 + 0 + 1 + 0 => 3

=cut
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
A "positive" integer is an integer greater than zero.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A positive (non-zero) integer is entered on the command-line.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <int>
  perl $0

    <int>    A positive integer
END
#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 359, Task #1: Digital Root (Perl)\n\n";
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
    elsif ($argc == 1)
    {
        my $int = $ARGV[0];

        $int =~ / ^ $RE{num}{int} $ /x
                 or error( qq["$int" is not a valid integer] );
        $int > 0 or error( "$int is not positive" );

        print "Input:  \$int = $int\n";

        my ($persistence, $digital_root) = find_persistence_and_root( $int );

        print "Output: Persistence  = $persistence\n";
        print "        Digital Root = $digital_root\n";
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_persistence_and_root
#-------------------------------------------------------------------------------
{
    my ($int) = @_;
    my  $pers = 0;
    my  $sum  = $int;

    while ($sum > 9)
    {
        my $s  = 0;
           $s += $_ for split //, $sum;
        $sum   = $s;
      ++$pers;
    }

    return ($pers, $sum);
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $int, $exp_pers, $exp_root) = split / \| /x, $line;

        for ($test_name, $int, $exp_pers, $exp_root)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my ($persistence, $digital_root) = find_persistence_and_root( $int );

        is $persistence,  $exp_pers, "$test_name: Persistence";
        is $digital_root, $exp_root, "$test_name: Digital Root";
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
Example 1|        38|2|2
Example 2|         7|0|7
Example 3|       999|2|9
Example 4|1999999999|3|1
Example 5|    101010|1|3
