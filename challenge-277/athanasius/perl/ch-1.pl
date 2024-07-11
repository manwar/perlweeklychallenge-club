#!perl

################################################################################
=comment

Perl Weekly Challenge 277
=========================

TASK #1
-------
*Count Common*

Submitted by: Mohammad Sajid Anwar

You are given two array of strings, @words1 and @words2.

Write a script to return the count of words that appears in both arrays exactly
once.

Example 1

  Input: @words1 = ("Perl", "is", "my", "friend")
         @words2 = ("Perl", "and", "Raku", "are", "friend")
  Output: 2

  The words "Perl" and "friend" appear once in each array.

Example 2

  Input: @words1 = ("Perl", "and", "Python", "are", "very", "similar")
         @words2 = ("Python", "is", "top", "in", "guest", "languages")
  Output: 1

Example 3

  Input: @words1 = ("Perl", "is", "imperative", "Lisp", "is", "functional")
         @words2 = ("Crystal", "is", "similar", "to", "Ruby")
  Output: 0

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
-----------
1. Only words matching exactly (including case) are considered "the same". For
   example, "Perl" and "perl" are treated as different words, as are "friend"
   and "friends".
2. Within the input strings, words are separated by whitespace only. Any punctu-
   ation characters are treated as part of the words.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If an explanation of the output is required, the flag "--verbose" is entered
   on the command-line.
3. The input word lists are entered as two strings. Within each string, words
   are separated by whitespace.

=cut
#===============================================================================

use v5.32.1;       # Enables strictures
use warnings;
use Const::Fast;
use Getopt::Long;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [--verbose] <words1-str> <words2-str>
  perl $0

    <words1-str>    String 1 of whitespace-separated words
    <words2-str>    String 2 of whitespace-separated words
    --verbose       Explain the output? [default: False]
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 277, Task #1: Count Common (Perl)\n\n";
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
        my ($verbose, $words1, $words2) = parse_command_line();

        printf "Input:  \@words1 = (%s)\n",
                join ', ', map { qq["$_"] } @$words1;

        printf "        \@words2 = (%s)\n",
                join ', ', map { qq["$_"] } @$words2;

        my $common = find_common_words( $words1, $words2 );
        my $count  = scalar @$common;

        print "Output: $count\n";

        if ($verbose && $count > 0)
        {
            printf "\nWord%s appearing exactly once in each array: %s\n",
                   ($count == 1 ? '' : 's'),
                    join ', ', map { qq["$_"] } @$common;
        }
    }
}

#-------------------------------------------------------------------------------
sub find_common_words
#-------------------------------------------------------------------------------
{
    my ($words1, $words2) = @_;
    my  @common;

    my  %dict1;
      ++$dict1{ $_ } for @$words1;

    my  %dict2;
      ++$dict2{ $_ } for @$words2;

    for my $key (keys %dict1)
    {
        if ($dict1{ $key } == 1 && exists $dict2{ $key } && $dict2{ $key } == 1)
        {
            push @common, $key;
        }
    }

    return [ sort @common ];
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my $verbose = 0;

    GetOptions
    (
        verbose => \$verbose

    )              or error( 'Error in command-line arguments' );

    my $argc = scalar @ARGV;

    $argc == 2     or error( "Expected 2 command-line arguments, found $argc" );

    my @words1 = split / \s+ /x, $ARGV[ 0 ];
    my @words2 = split / \s+ /x, $ARGV[ 1 ];

    return ($verbose, \@words1, \@words2);
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        while ($line =~ / \\ $ /x)
        {
            $line =~ s/ \\ $ / /x;

            my $next = <DATA>;

            $next =~ s/ ^ \s+ //x;
            $line .= $next;
        }

        my  ($test_name, $words1_str, $words2_str, $expected_str) =
             split / \| /x, $line;

        for ($test_name, $words1_str, $words2_str, $expected_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @words1   = split / \s+ /x, $words1_str;
        my @words2   = split / \s+ /x, $words2_str;
        my $common   = find_common_words( \@words1, \@words2 );
        my @expected = split / \s+ /x, $expected_str;

        is_deeply $common, \@expected, $test_name;
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
Example 1|Perl is my friend|Perl and Raku are friend|Perl friend
Example 2|Perl and Python are very similar|Python is top in guest languages|   \
          Python
Example 3|Perl is imperative Lisp is functional|Crystal is similar to Ruby|
