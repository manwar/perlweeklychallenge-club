#!perl

################################################################################
=comment

Perl Weekly Challenge 372
=========================

TASK #2
-------
*Largest Substring*

Submitted by: Mohammad Sajid Anwar

You are given a string.

Write a script to return the length of the largest substring between two equal
characters excluding the two characters. Return -1 if there is no such sub-
string.

Example 1

  Input: $str = "aaaaa"
  Output: 3

  For character "a", we have substring "aaa".

Example 2

  Input: $str = "abcdeba"
  Output: 5

  For character "a", we have substring "bcdeb".

Example 3

  Input: $str = "abbc"
  Output: 0

  For character "b", we have substring "".

Example 4

  Input: $str = "abcaacbc"
  Output: 4

  For character "a", we have substring "bca".
  For character "b", we have substring "caac".
  For character "c", we have substring "aacb".

Example 5

  Input: $str = "laptop"
  Output: 2

  For character "p", we have substring "to".

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
3. If the constant $VERBOSE is set to a true value, the largest substring(s) are
   listed in the output, immediately following the maximum length.

=cut
#===============================================================================

use v5.38.2;      # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $VERBOSE => 1;
const my $USAGE   => <<END;
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
    print "\nChallenge 372, Task #2: Largest Substring (Perl)\n\n";
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

        print qq[Input:  \$str = "$str"\n];

        my ($max_length, $substrings) = find_largest_substring( $str );

        printf "Output: %d%s\n", $max_length, $VERBOSE ?
               ' (' . join( ', ', map { qq["$_"] } @$substrings ) . ')' : '';
    }
    else
    {
        error( "Expected 0 or 1 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_largest_substring
#-------------------------------------------------------------------------------
{
    my ($str) = @_;
    my (%dict, @substrings);

    ++$dict{$_} for split //, $str;

    for my $char (grep { $dict{$_} > 1 } sort keys %dict)
    {
        # Note: quotemeta is applied here in case $char is a whitespace charac-
        #       ter (which would otherwise be ignored because of the /x)

        $str =~ / \Q$char\E (.*) \Q$char\E /x;

        push @substrings, $1;
    }

    my  $max_length = -1;

    for my $substring (@substrings)
    {
        my $len     = length $substring;
        $max_length = $len if $len > $max_length;
    }

    @substrings = grep { length == $max_length } @substrings;

    return ($max_length, \@substrings);
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    say 'Running the test suite';

    while (my $line = <DATA>)
    {
        chomp $line;

        # Note: The syntax for split() is:  split /PATTERN/,EXPR,LIMIT
        #       Setting LIMIT to -1 overrides the normal behaviour, which is to
        #       strip trailing empty fields

        my  ($test_name, $str, $expected, @exp_subs) = split / \| /x, $line, -1;

        for ($test_name, $str, $expected, @exp_subs)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my ($max_length, $substrings) = find_largest_substring( $str );

        is        $max_length,  $expected, "$test_name: count";
        is_deeply $substrings, \@exp_subs, "$test_name: substrings";
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
Example 1|aaaaa   | 3|aaa
Example 2|abcdeba | 5|bcdeb
Example 3|abbc    | 0|
Example 4|abcaacbc| 4|caac|aacb
Example 5|laptop  | 2|to
None     |abcdefgh|-1
