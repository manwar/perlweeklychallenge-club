#!perl

################################################################################
=comment

Perl Weekly Challenge 253
=========================

TASK #1
-------
*Split Strings*

Submitted by: Mohammad S Anwar

You are given an array of strings and a character separator.

Write a script to return all words separated by the given character excluding
empty string.

Example 1

  Input: @words = ("one.two.three","four.five","six")
         $separator = "."
  Output: "one","two","three","four","five","six"

Example 2

  Input: @words = ("$perl$$", "$$raku$")
         $separator = "$"
  Output: "perl","raku"

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

=cut
#===============================================================================

use v5.32.1;        # Enables strictures
use warnings;
use Const::Fast;
use Getopt::Long;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [--separator <Str>] [<strings> ...]
  perl $0

    --separator <Str>    A single-character separator
    [<strings> ...]      A non-empty list of strings
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 253, Task #1: Split Strings (Perl)\n\n";
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
        my ($separator, $strings) = parse_command_line();

        printf qq[Input:  \@strings   = (%s)\n],
               join ', ', map { qq["$_"] } @$strings;
        print  qq[        \$separator =  "$separator"\n];

        my $words = split_strings( $separator, $strings );

        printf qq[Output: %s\n], join ', ', map { qq["$_"] } @$words;
    }
}

#-------------------------------------------------------------------------------
sub split_strings
#-------------------------------------------------------------------------------
{
    my ($separator, $strings) = @_;
    my  @words;

    for my $string (@$strings)
    {
        push @words, split / \Q$separator\E /x, $string;
    }

    @words = grep { length > 0 } @words;

    return \@words;
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my $separator;

    GetOptions( 'separator=s' => \$separator )
        or error( 'Invalid command line argument(s)' );

    defined $separator
        or error( 'Missing separator' );

    length $separator == 1
        or error( 'Invalid separator' );

    scalar @ARGV > 0
        or error( 'No input strings found' );

    return ($separator, \@ARGV);
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $strings_str, $separator, $expected_str) =
             split / \| /x, $line;

        for ($test_name, $strings_str, $separator, $expected_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @strings  = split / \s+ /x, $strings_str;
        my @expected = split / \s+ /x, $expected_str;
        my $output   = split_strings( $separator, \@strings );

        is_deeply $output, \@expected, $test_name;
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
Example 1|one.two.three four.five six|.|one two three four five six
Example 2|$perl$$ $$raku$            |$|perl raku
