#!perl

################################################################################
=comment

Perl Weekly Challenge 394
=========================

TASK #1
-------
*Alternate Case*

Submitted by: Mohammad Sajid Anwar

You are given a string containing an equal number of uppercase and lowercase
English letters.

Write a script to [find] the minimum number of adjacent character swaps needed
to turn the given string into an alternate case string.

Example 1

  Input: $str = "aAbB"
  Output: 0

Example 2

  Input: $str = "AAbb"
  Output: 1

  Swap 1: "AbAb"

Example 3

  Input: $str = "AAAbbb"
  Output: 3

  Swap 1: "AAbAbb"
  Swap 2: "AbAAbb"
  Swap 3: "AbAbAb"

Example 4

  Input: $str = "aABb"
  Output: 1

  Swap 1: "aAbB"

Example 5

  Input: $str = "bBBAaa"
  Output: 2

  Swap 1: "BbBAaa"
  Swap 2: "BbBaAa"

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
2. A string, containing an equal number of uppercase and lowercase English
   letters, is entered on the command-line.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use boolean;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <str>
  perl $0

    <str>    A string of an equal number of upper- & lowercase English letters
END

use enum qw( UPPER_CASE LOWER_CASE );

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 394, Task #1: Alternate Case (Perl)\n\n";
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
        my $str = $ARGV[0];

        is_valid_str( $str ) or error( qq[The input string "$str" is invalid] );

        print qq[Input:  \$str = "$str"\n];

        my $min_swaps = find_min_swaps( $str );

        print "Output: $min_swaps\n";
    }
    else
    {
        error( "Expected 1 or 0 arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_min_swaps
#-------------------------------------------------------------------------------
{
    my ($str) = @_;

    is_valid_str( $str ) or die qq[The string "$str" is invalid];

    return 0 if is_alt_case_str( $str );

    my @strs = $str;

    for (my $swaps = 1; ; ++$swaps)
    {
        my @new_strs;

        for my $s (@strs)
        {
            my $swap_idxs = find_swaps( $s );

            for my $i (@$swap_idxs)
            {
                my $new_str = swap( $s, $i );

                return $swaps if is_alt_case_str( $new_str );

                push @new_strs, $new_str;
            }
        }

        @strs = @new_strs;
    }
}

#-------------------------------------------------------------------------------
sub find_swaps
#-------------------------------------------------------------------------------
{
    my ($str)  = @_;
    my  @chars = split //, $str;
    my  @indices;

    for my $i (0 .. $#chars - 1)
    {
        my $lhs = get_case( $chars[$i    ] );
        my $rhs = get_case( $chars[$i + 1] );

        push @indices, $i if $lhs != $rhs;
    }

    return \@indices;
}

#-------------------------------------------------------------------------------
sub swap
#-------------------------------------------------------------------------------
{
    my ($str, $i)  = @_;
    my  @chars     = split //, $str;
    my  $temp      = $chars[$i];

    $chars[$i    ] = $chars[$i + 1];
    $chars[$i + 1] = $temp;

    return join '', @chars;
}

#-------------------------------------------------------------------------------
sub is_valid_str
#-------------------------------------------------------------------------------
{
    my ($str) = @_;

    return false unless $str =~ / ^ [A-Z]* $ /ix;

    my $uc = 0;

    for my $char (split //, $str)
    {
        ++$uc if get_case( $char ) == UPPER_CASE;
    }

    return $uc * 2 == length $str;
}

#-------------------------------------------------------------------------------
sub is_alt_case_str
#-------------------------------------------------------------------------------
{
    my ($str) = @_;

    return true if length $str < 2;

    my @chars = split //, $str;
    my $last  = get_case( $chars[0] );

    for my $i (1 .. $#chars)
    {
        my $current = get_case( $chars[$i] );

        return false if $current == $last;

        $last = $current;
    }

    return true;
}

#-------------------------------------------------------------------------------
sub get_case
#-------------------------------------------------------------------------------
{
    return 'A' le $_[0] le 'Z' ? UPPER_CASE : LOWER_CASE;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $str, $expected) = split / \| /x, $line;

        for ($test_name, $str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $min_swaps = find_min_swaps( $str );

        is $min_swaps, $expected, $test_name;
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
Example 1|aAbB  |0
Example 2|AAbb  |1
Example 3|AAAbbb|3
Example 4|aABb  |1
Example 5|bBBAaa|2
