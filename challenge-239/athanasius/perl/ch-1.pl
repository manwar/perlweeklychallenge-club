#!perl

################################################################################
=comment

Perl Weekly Challenge 239
=========================

TASK #1
-------
*Same String*

Submitted by: Mohammad S Anwar

You are given two arrays of strings.

Write a script to find out if the word created by concatenating the array
elements is the same.

Example 1

  Input: @arr1 = ("ab", "c")
         @arr2 = ("a", "bc")
  Output: true

  Using @arr1, word1 => "ab" . "c" => "abc"
  Using @arr2, word2 => "a" . "bc" => "abc"

Example 2

  Input: @arr1 = ("ab", "c")
         @arr2 = ("ac", "b")
  Output: false

  Using @arr1, word1 => "ab" . "c" => "abc"
  Using @arr2, word2 => "ac" . "b" => "acb"

Example 3

  Input: @arr1 = ("ab", "cd", "e")
         @arr2 = ("abcde")
  Output: true

  Using @arr1, word1 => "ab" . "cd" . "e" => "abcde"
  Using @arr2, word2 => "abcde"

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
-----------
1. Concatenation may be performed ONLY in array order.
2. An empty array concatenates to the empty string.
3. The $SEPARATOR string is never used as an array element.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If $VERBOSE is set to a true value (the default), the output ("True" or
   "False") is followed by details of the two concatenated strings.

=cut
#===============================================================================

use v5.32.1;
use warnings;
use Const::Fast;
use Test::More;

const my $VERBOSE   =>  1;
const my $SEPARATOR => '*';
const my $USAGE     =>
qq{Usage:
  perl $0 [<strings> ...]
  perl $0

    [<strings> ...]    Two lists of strings, separated by the token "*"\n};

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 239, Task #1: Same String (Perl)\n\n";
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
        my ($array1, $array2) = parse_input();

        printf "Input:  \@array1 = (%s)\n",
                join ', ', map { qq["$_"] } @$array1;

        printf "        \@array2 = (%s)\n",
                join ', ', map { qq["$_"] } @$array2;

        my ($same, $word1, $word2) = same_string( $array1, $array2 );

        printf "Output: %s\n", $same ? 'True' : 'False';

        show_strings( $array1, $word1, $array2, $word2 ) if $VERBOSE;
    }
}

#-------------------------------------------------------------------------------
sub same_string
#-------------------------------------------------------------------------------
{
    my ($array1, $array2) = @_;
    my  $word1 = join '', @$array1;
    my  $word2 = join '', @$array2;

    return ($word1 eq $word2, $word1, $word2);
}

#-------------------------------------------------------------------------------
sub parse_input
#-------------------------------------------------------------------------------
{
    my @strings = @ARGV;
    my $count   = 0;

    for my $str (@strings)
    {
        ++$count if $str eq $SEPARATOR;
    }

    $count == 1 or error( 'The input list must contain exactly one separator' );

    my (@array1, @array2);
    my  $second = 0;

    for my $str (@strings)
    {
        if    ($second)
        {
            push @array2, $str;
        }
        elsif ($str eq $SEPARATOR)
        {
            $second = 1;
        }
        else
        {
            push @array1, $str;
        }
    }

    return (\@array1, \@array2);
}

#-------------------------------------------------------------------------------
sub show_strings
#-------------------------------------------------------------------------------
{
    my ($array1, $word1, $array2, $word2) = @_;

    print "\n";

    if (scalar @$array1 > 1)
    {
        printf qq[Using \@array1, word1 => %s => "%s"\n],
            join( ' . ', map { qq["$_"] } @$array1 ), $word1;
    }
    else
    {
        print  qq[Using \@array1, word1 => "$word1"\n];
    }

    if (scalar @$array2 > 1)
    {
        printf qq[Using \@array2, word2 => %s => "%s"\n],
            join( ' . ', map { qq["$_"] } @$array2 ), $word2;
    }
    else
    {
        print  qq[Using \@array2, word2 => "$word2"\n];
    }
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test, $arr1_str, $arr2_str, $exp_same, $exp_word1, $exp_word2) =
            split / \| /x, $line;

        for ($test, $arr1_str, $arr2_str, $exp_same, $exp_word1, $exp_word2)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @array1 = split / \s+ /x, $arr1_str;
        my @array2 = split / \s+ /x, $arr2_str;

        my ($same, $word1, $word2) = same_string( \@array1, \@array2 );

        my $same_str = $same ? 'True' : 'False';

        is $same_str, $exp_same,  "$test: same";
        is $word1,    $exp_word1, "$test: word1";
        is $word2,    $exp_word2, "$test: word2";
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
Example 1|ab c   |a bc |True |abc  |abc
Example 2|ab c   |ac b |False|abc  |acb
Example 3|ab cd e|abcde|True |abcde|abcde
