#!perl

################################################################################
=comment

Perl Weekly Challenge 319
=========================

TASK #1
-------
*Word Count*

Submitted by: Mohammad Sajid Anwar

You are given a list of words containing alphabetic characters only.

Write a script to return the count of words either starting with a vowel or
ending with a vowel.

Example 1

  Input: @list = ("unicode", "xml", "raku", "perl")
  Output: 2

  The words are "unicode" and "raku".

Example 2

  Input: @list = ("the", "weekly", "challenge")
  Output: 2

Example 3

  Input: @list = ("perl", "python", "postgres")
  Output: 0

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
2. A non-empty list of words is entered on the command-line.

Notes
-----
1. From Example 2, it appears that "y" is not considered a vowel, even when (as
   there) it functions as one.
2. Vowels are specified in lowercase, and are assumed to have uppercase counter-
   parts.
3. If support for non-English European languages is wanted, vowels with dia-
   critics ("è", "é", "ê", etc.) may be added to the constant array @VOWELS.
4. Non-alphabetic chars in the input are silently ignored.

=cut
#===============================================================================

use v5.32;         # Enables strictures
use warnings;
use utf8;
use Const::Fast;
use Set::Scalar;
use Test::More;

const my @VOWELS => qw( a e i o u );
const my $VOWELS => Set::Scalar->new( @VOWELS );
const my $USAGE  => <<END;
Usage:
  perl $0 <list>
  perl $0

    <list>    A non-empty list of words
END

my $vowels;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 319, Task #1: Word Count (Perl)\n\n";
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
        my @list = @ARGV;

        printf "Input:  \@list = (%s)\n", join ', ', map { qq["$_"] } @list;

        my $count = count_words( \@list );

        print  "Output: $count\n";
    }
}

#-------------------------------------------------------------------------------
sub count_words
#-------------------------------------------------------------------------------
{
    my ($list) = @_;
    my  $count = 0;

    for my $word (@$list)
    {
        my $first = substr $word,  0, 1;
        my $last  = substr $word, -1;

        ++$count if $VOWELS->has( lc $first ) || $VOWELS->has( lc $last );
    }

    return $count;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $list_str, $expected) = split / \| /x, $line;

        for ($test_name, $list_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @list  = split / \s+ /x, $list_str;
        my $count = count_words( \@list );

        is $count, $expected, $test_name;
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
Example 1|unicode xml raku perl|2
Example 2|the weekly challenge |2
Example 3|perl python postgres |0
Capitals |Unicode xml RAKU Perl|2
