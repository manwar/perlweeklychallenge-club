#!perl

################################################################################
=comment

Perl Weekly Challenge 372
=========================

TASK #1
-------
*Rearrange Spaces*

Submitted by: Mohammad Sajid Anwar

You are given a string text of words that are placed among number of spaces.

Write a script to rearrange the spaces so that there is an equal number of
spaces between every pair of adjacent words and that number is maximised. If you
can't distribute, place the extra spaces at the end. Finally return the string.

Example 1

  Input: $str = "  challenge  "
  Output: "challenge    "

  We have 4 spaces and 1 word. So all spaces go to the end.

Example 2

  Input: $str = "coding  is  fun"
  Output: "coding  is  fun"

  We have 4 spaces and 3 words (2 gaps). So 2 spaces per gap.

Example 3

  Input: $str = "a b c  d"
  Output: "a b c d "

  We have 4 spaces and 4 words (3 gaps). So 1 space per gap and 1 remainder.

Example 4

  Input: $str = "  team      pwc  "
  Output: "team          pwc"

  We have 10 spaces and 2 words (1 gap). So 10 spaces per gap.

Example 5

  Input: $str = "   the  weekly  challenge  "
  Output: "the    weekly    challenge "

  We have 9 spaces and 3 words (2 gaps). So 4 spaces per gap and 1 remainder.

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
2. A single string is entered on the command-line.

=cut
#===============================================================================

use v5.38.2;    # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <str>
  perl $0

    <str>    A string
END
#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 372, Task #1: Rearrange Spaces (Perl)\n\n";
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

        print qq[Input: \$str = "$str"\n];

        my $rearranged = rearrange_spaces( $str );

        print qq[Output:       "$rearranged"\n];
    }
    else
    {
        error( "Expected 0 or 1 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub rearrange_spaces
#-------------------------------------------------------------------------------
{
    my ($str)        =  @_;
    my  $n_spaces    = ($str =~ tr/ //);
    my  @words       =  grep { length } split / \s+ /x, $str;
    my  $n_words     =  scalar @words;
    my  $rearranged  =  $str;            # Correct if $n_words == 0

    if    ($n_words == 1)
    {
        $rearranged  = $words[0] . ' ' x $n_spaces;
    }
    elsif ($n_words  > 1)
    {
        my $gap_size = int( $n_spaces / ($n_words - 1) );
        my $gap      = ' ' x $gap_size;
        my $end_size = $n_spaces - ($gap_size * ($n_words - 1));
        $rearranged  = join( $gap, @words ) . ' ' x $end_size;
    }

    return $rearranged;
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

        $test_name =~ s/ \s+ $ //x;

        my $rearranged = rearrange_spaces( $str );

        is $rearranged, $expected, $test_name;
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
Example 1  |  challenge  |challenge    |
Example 2  |coding  is  fun|coding  is  fun|
Example 3  |a b c  d|a b c d |
Example 4  |  team      pwc  |team          pwc|
Example 5  |   the  weekly  challenge  |the    weekly    challenge |
Spaces only|     |     |
