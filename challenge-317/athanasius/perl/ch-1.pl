#!perl

################################################################################
=comment

Perl Weekly Challenge 317
=========================

TASK #1
-------
*Acronyms*

Submitted by: Mohammad Sajid Anwar

You are given an array of words and a word.

Write a script to return true if concatenating the first letter of each word in
the given array matches the given word, return false otherwise.

Example 1

  Input: @array = ("Perl", "Weekly", "Challenge")
         $word  = "PWC"
  Output: true

Example 2

  Input: @array = ("Bob", "Charlie", "Joe")
         $word  = "BCJ"
  Output: true

Example 3

  Input: @array = ("Morning", "Good")
         $word  = "MM"
  Output: false

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
Matching is NOT case-sensitive. (Rationale: An acronym may be capitalised when
its expansion is not; e.g., "DRY" = "don't repeat yourself".)

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. An acronym is entered on the command-line, followed by a list of words.

=cut
#===============================================================================

use v5.32;          # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <word> [<array> ...]
  perl $0

    <word>           An acronym
    [<array> ...]    A non-empty list of words
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 317, Task #1: Acronyms (Perl)\n\n";
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
        my ($word, @array) = @ARGV;

        printf "Input:  \@array = (%s)\n", join ', ', map { qq["$_"] } @array;
        print  "        \$word  =  \"$word\"\n";

        my $acronym = is_acronym( \@array, $word );

        printf "Output: %s\n", $acronym ? 'true' : 'false';
    }
}

#-------------------------------------------------------------------------------
sub is_acronym
#-------------------------------------------------------------------------------
{
    my ($array, $word) = @_;
    my  $acronym;

    for my $elem (@$array)
    {
        $acronym .= substr $elem, 0, 1;
    }

    return lc $acronym eq lc $word;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $array_str, $word, $expected_str) =
             split / \| /x, $line;

        for ($test_name, $array_str, $word, $expected_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @array    = split / \s+ /x, $array_str;
        my $acronym  = is_acronym( \@array, $word );
        my $expected = $expected_str eq 'true';

        is $acronym, $expected, $test_name;
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
Example 1|Perl Weekly Challenge|PWC|true
Example 2|Bob Charlie Joe      |BCJ|true
Example 3|Morning Good         |MM |false
Diff case|don't repeat yourself|DRY|true
