#!perl

################################################################################
=comment

Perl Weekly Challenge 254
=========================

TASK #2
-------
*Reverse Vowels*

Submitted by: Mohammad S Anwar

You are given a string, $s.

Write a script to reverse all the vowels (a, e, i, o, u) in the given string.

Example 1

  Input: $s = "Raku"
  Output: "Ruka"

Example 2

  Input: $s = "Perl"
  Output: "Perl"

Example 3

  Input: $s = "Julia"
  Output: "Jaliu"

Example 4

  Input: $s = "Uiua"
  Output: "Auiu"

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
If no command-line arguments are given, the test suite is run.

Note
----
It appears from Example 4 that a new vowel placed into position i of the string
is capitaltalized if and only if the vowel originally in position i was itself
capitalized.

=cut
#===============================================================================

use v5.32.1;     # Enables strictures
use warnings;
use Const::Fast;
use List::Util   qw( any );
use Test::More;

const my @UC_VOWELS => qw[ A E I O U ];
const my $USAGE     => <<END;
Usage:
  perl $0 <s>
  perl $0

    <s>    A string
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 254, Task #2: Reverse Vowels (Perl)\n\n";
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
        my $s = $ARGV[ 0 ];

        print  qq[Input:  \$s = "$s"\n];

        printf qq[Output:      "%s"\n], reverse_vowels( $s );
    }
    else
    {
        error( "Expected 1 or 0 arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub reverse_vowels
#-------------------------------------------------------------------------------
{
    my ($s)       = @_;
    my  $reversed = '';
    my  @chars    = split '', $s;
    my (@indices, @vowels);

    for my $i (0 .. $#chars)
    {
        my $char = $chars[ $i ];

        if (any { $_ eq uc $char } @UC_VOWELS)
        {
            push @indices, $i;
            push @vowels,  lc $char;
        }
    }

    for my $i (0 .. $#chars)
    {
        if (@indices && $indices[ 0 ] == $i)
        {
            shift @indices;

            my $vowel  = pop @vowels;
               $vowel  = uc $vowel if any { $_ eq $chars[ $i ] } @UC_VOWELS;
            $reversed .= $vowel;
        }
        else
        {
            $reversed .= $chars[ $i ];
        }
    }

    return $reversed;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $s, $expected) = split / \| /x, $line;

        for ($test_name, $s, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $reversed = reverse_vowels( $s );

        is $reversed, $expected, $test_name;
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
Example 1|Raku       |Ruka
Example 2|Perl       |Perl
Example 3|Julia      |Jaliu
Example 4|Uiua       |Auiu
No vowels|Uvwxyz     |Uvwxyz
Two words|Happy Irene|Heppy Erina
