#!perl

################################################################################
=comment

Perl Weekly Challenge 245
=========================

TASK #1
-------
*Sort Language*

Submitted by: Mohammad S Anwar

You are given two array of languages and its popularity.

Write a script to sort the language based on popularity.

Example 1

  Input: @lang = ('perl', 'c', 'python')
         @popularity = (2, 1, 3)
  Output: ('c', 'perl', 'python')

Example 2

  Input: @lang = ('c++', 'haskell', 'java')
         @popularity = (1, 3, 2)
  Output: ('c++', 'java', 'haskell')

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. Language names are entered as a single, whitespace-separated string named
   "lang", for example:  --lang="c++ haskell java"
3. Popularity ratings are entered as a list of unsigned integers. The number of
   popularity ratings must equal the number of language names. Duplicate popu-
   larity ratings are allowed: languages with identical popularities are sorted
   in alphabetical order.

=cut
#===============================================================================

use v5.32.1;        # Enables strictures
use warnings;
use Const::Fast;
use Getopt::Long;
use List::MoreUtils qw( mesh );
use Regexp::Common  qw( number );
use Test::More;

const my $USAGE =>
"Usage:
  perl $0 [--lang=<Str>] [<popularity> ...]
  perl $0

    --lang=<Str>          A whitespace-separated list of language names
    [<popularity> ...]    A list of popularity ratings for the given languages
";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 245, Task #1: Sort Language (Perl)\n\n";
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
        my ($languages, $popularity) = parse_command_line();

        printf "Input: \@languages  = (%s)\n", format_langs( $languages );
        printf "       \@popularity = (%s)\n", join ', ', @$popularity;

        my $sorted = sort_languages( $languages, $popularity );

        printf "Output:              (%s)\n",  format_langs( $sorted );
    }
}

#-------------------------------------------------------------------------------
sub sort_languages
#-------------------------------------------------------------------------------
{
    my ($languages, $popularity) = @_;

    my  %dict   = mesh @$languages, @$popularity;
    my  @sorted = sort
                  {                                      # Sort (ascending) by:
                      $dict{ $a } <=> $dict{ $b } ||     # 1. popularity; then
                             $a   cmp        $b          # 2. alphabetical order

                  } @$languages;

    return \@sorted;
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my $lang_str;

    GetOptions( 'lang=s' => \$lang_str )
                      or error( 'Error in command line arguments' );

    defined $lang_str or error( 'No language names given' );

    my @languages  = split / \s+ /x, $lang_str;
    my @popularity = @ARGV;

    for (@popularity)
    {
        / ^ $RE{num}{int} $ /x
                      or error( qq["$_" is not a valid integer] );

        $_ >= 0       or error( qq["$_" is negative] );
    }

    scalar @languages == scalar @popularity
                      or error( 'The input lists have different sizes' );

    return (\@languages, \@popularity);
}

#-------------------------------------------------------------------------------
sub format_langs
#-------------------------------------------------------------------------------
{
    my ($languages) = @_;

    return join ', ', map { "'$_'" } @$languages;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $languages_str, $popularity_str, $expected_str) =
             split / \| /x, $line;

        for ($test_name, $languages_str, $popularity_str, $expected_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @languages  = split / \s+ /x, $languages_str;
        my @popularity = split / \s+ /x, $popularity_str;
        my @expected   = split / \s+ /x, $expected_str;
        my $sorted     = sort_languages( \@languages, \@popularity );

        is_deeply $sorted, \@expected, $test_name;
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
Example 1|perl c python   |2 1 3|c perl python
Example 2|c++ haskell java|1 3 2|c++ java haskell
