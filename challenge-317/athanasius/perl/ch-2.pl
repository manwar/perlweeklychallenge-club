#!perl

################################################################################
=comment

Perl Weekly Challenge 317
=========================

TASK #2
-------
*Friendly Strings*

Submitted by: Mohammad Sajid Anwar

You are given two strings.

Write a script to return true if swapping any two letters in one string match
the other string, return false otherwise.

Example 1

  Input: $str1 = "desc", $str2 = "dsec"
  Output: true

Example 2

  Input: $str1 = "fuck", $str2 = "fcuk"
  Output: true

Example 3

  Input: $str1 = "poo", $str2 = "eop"
  Output: false

Example 4

  Input: $str1 = "stripe", $str2 = "sprite"
  Output: true

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
-----------
1. True is returned if and only if exactly one swap of two letters in the first
   string makes it identical to the second string.
2. The letters swapped must be at different locations within the first string,
   but they may be the same character.
3. Matching is case-sensitive.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. Two strings are entered on the command-line.

=cut
#===============================================================================

use v5.32;        # Enables strictures
use warnings;
use Array::Compare;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <str1> <str2>
  perl $0

    <str1>    First  string
    <str2>    Second string
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 317, Task #2: Friendly Strings (Perl)\n\n";
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
        my ($str1, $str2) = @ARGV;

        print qq[Input:  \$str1 = "$str1", \$str2 = "$str2"\n];

        my $friendly = friendly_strings( $str1, $str2 );

        printf "Output: %s\n", $friendly ? 'true' : 'false';
    }
    else
    {
        error( "Expected 0 or 2 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub friendly_strings
#-------------------------------------------------------------------------------
{
    my ($str1, $str2) = @_;

    return '' unless length $str1 == length $str2;

    my @chars1 = split //, $str1;
    my @chars2 = split //, $str2;
    my $comp   = Array::Compare->new;

    return '' unless $comp->compare( [ sort @chars1 ], [ sort @chars2 ] );
    
    for my $i (0 .. $#chars1)
    {
        for my $j ($i + 1 .. $#chars1)
        {
            my @swapped = (@chars1[ 0      .. $i - 1 ], $chars1[ $j ],
                           @chars1[ $i + 1 .. $j - 1 ], $chars1[ $i ],
                           @chars1[ $j + 1 .. $#chars1 ]);

            return 1 if $comp->compare( \@swapped, \@chars2 );
        }
    }

    return '';
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $str1, $str2, $expected_str) = split / \| /x, $line;

        for ($test_name, $str1, $str2, $expected_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $friendly = friendly_strings( $str1, $str2 );
        my $expected = $expected_str eq 'true';

        is $friendly, $expected, $test_name;
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
Example 1  |desc  |dsec  |true
Example 2  |fuck  |fcuk  |true
Example 3  |poo   |eop   |false
Example 4  |stripe|sprite|true
Identical 1|abcdef|abcdef|false
Identical 2|abccde|abccde|true
Bookends   |dater |rated |true
