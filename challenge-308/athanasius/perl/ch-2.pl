#!perl

################################################################################
=comment

Perl Weekly Challenge 308
=========================

TASK #2
-------
*Decode XOR*

Submitted by: Mohammad Sajid Anwar

You are given an encoded array and an initial integer.

Write a script to find the original array that produced the given encoded array.
It was encoded such that encoded[i] = orig[i] XOR orig[i + 1].

Example 1

  Input: @encoded = (1, 2, 3), $initial = 1
  Output: (1, 0, 2, 1)

  Encoded array created like below, if the original array was (1, 0, 2, 1)
  $encoded[0] = (1 xor 0) = 1
  $encoded[1] = (0 xor 2) = 2
  $encoded[2] = (2 xor 1) = 3

Example 2

  Input: @encoded = (6, 2, 7, 3), $initial = 4
  Output: (4, 2, 0, 7, 4)

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
-----------
1. The initial integer is unsigned, and the elements of the encoded list are
   also unsigned integers.
2. The XOR operation is bitwise XOR, not logical XOR.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The initial unsigned integer is entered on the command-line, followed by a
   non-empty list of encoded unsigned integers.

=cut
#===============================================================================

use v5.32;         # Enables strictures and warnings
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <initial> [<encoded> ...]
  perl $0

    <initial>          An initial unsigned integer
    [<encoded> ...]    A non-empty list of unsigned integers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 308, Task #2: Decode XOR (Perl)\n\n";
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
        error( 'Expected 0 or 2+ command-line arguments, found 1' );
    }
    else
    {
        my  ($initial, @encoded) = @ARGV;

        for ($initial, @encoded)
        {
            / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] );
            $_ >= 0                or error( "$_ is negative" );
        }

        printf "Input:  \@encoded = (%s), \$initial = %d\n",
                join( ', ', @encoded ), $initial;

        my $decoded = decode_xor( \@encoded, $initial );

        printf "Output: (%s)\n", join ', ', @$decoded;
    }
}

#-------------------------------------------------------------------------------
sub decode_xor
#-------------------------------------------------------------------------------
{
    my ($encoded, $initial) = @_;
    my  @decoded = $initial; 
    my  $last    = $initial ^ $encoded->[ 0 ];

    push @decoded, $last;

    for my $i (1 .. $#$encoded)
    {
        $last ^= $encoded->[ $i ];

        push @decoded, $last;
    }

    return \@decoded;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $encoded_str, $initial, $expected_str) =
             split / \| /x, $line;

        for ($test_name, $encoded_str, $initial, $expected_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @encoded  = split / \s+ /x, $encoded_str;
        my @expected = split / \s+ /x, $expected_str;
        my $decoded  = decode_xor( \@encoded, $initial );

        is_deeply $decoded, \@expected, $test_name;
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
Example 1|1 2 3  |1|1 0 2 1
Example 2|6 2 7 3|4|4 2 0 7 4
