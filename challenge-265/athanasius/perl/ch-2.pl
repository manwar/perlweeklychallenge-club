#!perl

################################################################################
=comment

Perl Weekly Challenge 265
=========================

TASK #2
-------
*Completing Word*

Submitted by: Mohammad Sajid Anwar

You are given a string, $str containing alphnumeric characters and array of
strings (alphabetic characters only), @str.

Write a script to find the shortest completing word. If none found return empty
string.

    A completing word is a word that contains all the letters in the given
    string, ignoring space and number. If a letter appeared more than once in
    the given string then it must appear the same number or more in the word.

Example 1

  Input: $str = 'aBc 11c'
         @str = ('accbbb', 'abc', 'abbc')
  Output: 'accbbb'

  The given string contains following, ignoring case and number:
  a 1 times
  b 1 times
  c 2 times

  The only string in the given array that satisfies the condition is 'accbbb'.

Example 2

  Input: $str = 'Da2 abc'
         @str = ('abcm', 'baacd', 'abaadc')
  Output: 'baacd'

  The given string contains following, ignoring case and number:
  a 2 times
  b 1 times
  c 1 times
  d 1 times

  The are 2 strings in the given array that satisfies the condition:
  'baacd' and 'abaadc'.

  Shortest of the two is 'baacd'

Example 3

  Input: $str = 'JB 007'
         @str = ('jj', 'bb', 'bjb')
  Output: 'bjb'

  The given string contains following, ignoring case and number:
  j 1 times
  b 1 times

  The only string in the given array that satisfies the condition is 'bjb'.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The string $str is entered as a named argument on the command-line.
3. Strings of the list @str are entered as unnamed arguments on the command-
   line.

Assumptions
-----------
1. From the Examples, it appears that case is ignored when searching for a com-
   pleting word.
2. If there are two or more shortest completing words, choose the first (lowest)
   by ascending alphabetical order.

=cut
#===============================================================================

use v5.32.1;       # Enables strictures
use warnings;
use Const::Fast;
use Getopt::Long;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [--str=<Str>] [<strs> ...]
  perl $0

    --str=<Str>     String of alphnumeric chars and/or whitespace
    [<strs> ...]    List of strings of alphabetic characters only
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 265, Task #2: Completing Word (Perl)\n\n";
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
        my ($str, $strs) = parse_command_line();

        print  "Input:  \$str  = '$str'\n";
        printf "        \@strs = (%s)\n", join ', ', map { "'$_'" } @$strs;

        my $word = find_completing_word( $str, $strs );

        print  "Output: '$word'\n";
    }
}

#-------------------------------------------------------------------------------
sub find_completing_word
#-------------------------------------------------------------------------------
{
    my ($str, $strings) = @_;
    my  %required;

    for my $char (split //, $str)
    {
        ++$required{ lc $char } if $char =~ / ^ [[:alpha:]] $ /x;
    }

    my @candidates;

    L_STRINGS: for my $string (@$strings)
    {
        my %chars;
         ++$chars{ lc() } for split //, $string;

        for my $key (keys %required)
        {
            next L_STRINGS unless exists $chars{ $key } &&
                                  $chars{ $key } >= $required{ $key };
        }

        push @candidates, $string;
    }

    @candidates = sort { length $a <=> length $b || $a cmp $b } @candidates;

    return scalar @candidates > 0 ? $candidates[ 0 ] : '';
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my ($str);

    GetOptions
    (
        'str=s' => \$str,
    )                       or error( 'Invalid command-line arguments' );

    $str // error( 'Missing $str' );
    $str =~ / ^ [A-Za-z0-9\s]* $ /x
                            or error( qq["$str" is not a valid \$str] );

    my @strs = @ARGV;

    / ^ [A-Za-z]* $ /x      or error( qq["$_" is not a valid value for \@strs] )
        for @strs;

    return ($str, \@strs);
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $str, $strs_str, $expected) = split / \| /x, $line;

        for ($test_name, $str, $strs_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @str  = split / \s+ /x, $strs_str;
        my $word = find_completing_word( $str, \@str );

        is $word, $expected, $test_name;
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
Example 1|aBc 11c|accbbb abc    abbc  |accbbb
Example 2|Da2 abc|abcm   baacd  abaadc|baacd
Example 3|JB 007 |jj     bb     bjb   |bjb
Sort     |Da2 abc|abcm   baacdf baacde|baacde
None     |Abcd 4f|abc    df     acf   |
