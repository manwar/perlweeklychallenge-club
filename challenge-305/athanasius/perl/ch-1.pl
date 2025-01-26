#!perl

################################################################################
=comment

Perl Weekly Challenge 305
=========================

TASK #1
-------
*Binary Prefix*

Submitted by: Mohammad Sajid Anwar

You are given a binary array.

Write a script to return an array of booleans where the partial binary number up
to that point is prime.

Example 1

  Input: @binary = (1, 0, 1)
  Output: (false, true, true)

  Sub-arrays (base-10):
  (1): 1 - not prime
  (1, 0): 2 - prime
  (1, 0, 1): 5 - prime

Example 2

  Input: @binary = (1, 1, 0)
  Output: (false, true, false)

  Sub-arrays (base-10):
  (1): 1 - not prime
  (1, 1): 3 - prime
  (1, 1, 0): 6 - not prime

Example 3

  Input: @binary = (1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1)
  Output: (false, true, true, false, false, true, false, false, false, false,
  false, false, false, false, false, false, false, false, false, true)

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty binary string is entered on the command-line.

=cut
#===============================================================================

use v5.32;            # Enables strictures
use warnings;
use Const::Fast;
use Math::Prime::Util qw( is_prime );
use Test::More;

const my $USAGE => <<END;
Usage:
  Usage:
  perl $0 <digits>
  perl $0

    <digits>    A non-empty string of binary digits
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 305, Task #1: Binary Prefix (Perl)\n\n";
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
        my $digits = $ARGV[ 0 ];

        $digits =~ / ^ [01]+ $ /x
               or error( qq["$digits" is not a valid string of binary digits] );

        my @binary = split //, $digits;

        printf "Input:  \@binary = (%s)\n", join ', ', @binary;

        my $prime = binary_prefix( \@binary );

        printf "Output: (%s)\n",
                join ', ', map { $_ ? 'true' : 'false' } @$prime;
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub binary_prefix
#-------------------------------------------------------------------------------
{
    my ($binary) = @_;
    my  $bin_str = '';
    my  @prime;

    for my $digit (@$binary)
    {
        $bin_str .= $digit;

        my $decimal = oct "0b$bin_str";

        push @prime, is_prime( $decimal ) ? 1 : 0;
    }

    return \@prime;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $bin_str, $exp_str) = split / \| /x, $line;

        for ($test_name, $bin_str, $exp_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @binary   = split //, $bin_str;
        my @expected = split //, $exp_str;
        my $prime    = binary_prefix( \@binary );

        is_deeply $prime, \@expected, $test_name;
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
Example 1|101                 |011
Example 2|110                 |010
Example 3|11110100001010010001|01100100000000000001
