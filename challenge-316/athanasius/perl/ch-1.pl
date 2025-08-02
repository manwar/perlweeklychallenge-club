#!perl

################################################################################
=comment

Perl Weekly Challenge 316
=========================

TASK #1
-------
*Circular*

Submitted by: Mohammad Sajid Anwar

You are given a list of words.

Write a script to find out whether the last character of each word is the first
character of the following word.

Example 1

  Input: @list = ("perl", "loves", "scala")
  Output: true

Example 2

  Input: @list = ("love", "the", "programming")
  Output: false

Example 3

  Input: @list = ("java", "awk", "kotlin", "node.js")
  Output: true

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
2. If matching is to be case-INsensitive, the flag "-i" is entered on the
   command-line; then:
3. A non-empty list of words is entered on the command-line.

=cut
#===============================================================================

use v5.32;          # Enables strictures
use warnings;
use Const::Fast;
use Getopt::Std;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [-i] [<list> ...]
  perl $0

    -i              Comparisons are case-insensitive? [default: False]
    [<list> ...]    A non-empty list of words
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 316, Task #1: Circular (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    if (scalar @ARGV == 0)
    {
        run_tests();
    }
    else
    {
        our $opt_i;         # = matches are case-INsensitive

        getopts( 'i' );

        my @list = @ARGV;

        scalar @list > 0 or error( 'The word list is empty' );

        printf "Input:  \@list = (%s)\n", join ', ', map { qq["$_"] } @list;
        printf "        (Comparisons %s case-sensitive)\n",
                         $opt_i ? 'are NOT' : 'ARE';

        my $result = solve( \@list, !$opt_i );

        printf "Output: %s\n", $result ? 'true' : 'false';
    }
}

#-------------------------------------------------------------------------------
sub solve
#-------------------------------------------------------------------------------
{
    my ($list, $case_sensitive) = @_;

    return 1 if scalar @$list < 2;

    for my $i (0 .. $#$list - 1)
    {
        my $first = substr                 $list->[ $i + 1 ],   0, 1;
        my $last  = substr scalar( reverse $list->[ $i     ] ), 0, 1;

        return '' unless $case_sensitive ?    $first eq    $last 
                                         : lc $first eq lc $last;
    }

    return 1;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $case_sensitive_str, $list_str, $expected_str) =
             split / \| /x, $line;

        for ($test_name, $case_sensitive_str, $list_str, $expected_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $sensitive = $case_sensitive_str eq 'Y';
        my @list      = split / \s+ /x, $list_str;
        my $result    = solve( \@list, $sensitive );
        my $expected  = $expected_str eq 'true';

        is $result, $expected, $test_name;
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
Example 1|Y|perl loves scala       |true
Example 2|Y|love the programming   |false
Example 3|Y|java awk kotlin node.js|true
Case 1   |Y|Snap Perl Linux X x    |false
Case 2   |N|Snap Perl Linux X x    |true
