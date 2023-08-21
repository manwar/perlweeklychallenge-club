#!perl

################################################################################
=comment

Perl Weekly Challenge 230
=========================

TASK #2
-------
*Count Words*

Submitted by: Mohammad S Anwar

You are given an array of words made up of alphabetic characters and a prefix.

Write a script to return the count of words that starts with the given prefix.

Example 1

  Input: @words  = ("pay", "attention", "practice", "attend")
         $prefix = "at"
  Output: 2

  Two words "attention" and "attend" starts with the given prefix "at".

Example 2

  Input: @words  = ("janet", "julia", "java", "javascript")
         $prefix = "ja"
  Output: 3

  Three words "janet", "java" and "javascript" starts with the given prefix
  "ja".

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
If the prefix and the word are identical, this is considered a match.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If $CASE-SENSITIVE is set to a true value (the default), the prefix must be
   an exact match; otherwise, e.g., "and" is considered a prefix of "Andes".
3. If $VERBOSE is set to a true value (the default), the solution is followed by
   a list of the matching words.

=cut
#===============================================================================

use strict;
use warnings;
use Const::Fast;
use Test::More;

const my $CASE_SENSITIVE => 1;
const my $VERBOSE        => 1;
const my $USAGE          =>
"Usage:
  perl $0 <prefix> [<words> ...]
  perl $0

    <prefix>         Prefix made up of alphabetic characters
    [<words> ...]    List of words made up of alphabetic characters\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 230, Task #2: Count Words (Perl)\n\n";
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
        my ($prefix, $words) = parse_command_line();

        printf "Input:  \@words  = (%s)\n", join ', ', map { qq["$_"] } @$words;
        print  "        \$prefix =  \"$prefix\"\n";

        my $matches = find_matches( $prefix, $words );

        printf "Output: %d\n", scalar @$matches;

        if ($VERBOSE)
        {
            printf "\nWords starting with the prefix \"$prefix\": %s\n",
                    join ', ', map { qq["$_"] } @$matches;
        }
    }
}

#-------------------------------------------------------------------------------
sub find_matches
#-------------------------------------------------------------------------------
{
    my ($prefix, $words) = @_;
    my  $regex           = $CASE_SENSITIVE ? qr/ ^ $prefix /x
                                           : qr/ ^ $prefix /ix;
    my  @matches;

    for my $word (@$words)
    {
        push @matches, $word if $word =~ $regex;
    }

    return \@matches;
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my ($prefix, @words) = @ARGV;

    for my $word ($prefix, @words)
    {
        $word =~ / ^ [A-Za-z]+ $ /x or error( qq[Invalid input word "$word"] );
    }

    return ($prefix, \@words);
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $prefix, $words_str, $expected_str) =
             split / \| /x, $line;

        for ($test_name, $prefix, $words_str, $expected_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @words    = split / \s+ /x, $words_str;
        my @expected = split / \s+ /x, $expected_str;
        my $matches  = find_matches( $prefix, \@words );

        is_deeply $matches, \@expected, $test_name;
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
Example 1 |at |pay attention practice attend|attention attend
Example 2 |ja |janet julia java javascript  |janet java javascript
No matches|xyz|in the beginning             |
Non-prefix|and|understand grandly landrover |
Mixed     |and|understand and andes         |and andes
