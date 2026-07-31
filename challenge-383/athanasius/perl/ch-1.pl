#!perl

################################################################################
=comment

Perl Weekly Challenge 383
=========================

TASK #1
-------
*Similar List*

Submitted by: Mohammad Sajid Anwar

You are given three list of strings.

Write a script to find out if the first two list are similar with the help the
third list. The third list contains the similar words map.

Example 1

  Input: $list1 = ("great", "acting")
         $list2 = ("fine", "drama")
         $list3 = (["great", "fine"], ["acting", "drama"])
  Output: true

Example 2

  Input: $list1 = ("apple", "pie")
         $list2 = ("banana", "pie")
         $list3 = (["apple", "peach"], ["peach", "banana"])
  Output: false

Example 3

  Input: $list1 = ("perl4", "python")
         $list2 = ("raku", "python")
         $list3 = (["perl4", "perl5", "raku"])
  Output: true

Example 4

  Input: $list1 = ("enjoy", "challenge")
         $list2 = ("love", "weekly", "challenge")
         $list3 = (["enjoy", "love"])
  Output: false

Example 5

  Input: $list1 = ("fast", "car")
         $list2 = ("quick", "vehicle")
         $list3 = (["quick", "fast"], ["vehicle", "car"])
  Output: true

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
2. Two or more strings are entered on the command-line. Each string contains a
   list of words separated by whitespace.

Assumptions
-----------
1. Two lists are similar if and only if they have similar words in the same
   positions within the lists. Corollary: to be similar, lists must contain the
   same number of words.
2. Word comparisons are case-sensitive.
3. Similarity is not transitive. This is counter-intuitive, but Example 2 shows
   that if "apple" is similar to "peach", and "peach" is (separately) similar to
   "banana", it does NOT follow that "apple" is similar to "banana".
4. The similar-words map (list3) is optional; if it is omitted, the lists must
   be identical to be considered similar.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use boolean;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <n>
  perl $0

    <n>    The target number, an integer > 1
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 383, Task #1: Similar List (Perl)\n\n";
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
        error( 'Expected 0 or 2+ arguments, found 1' );
    }
    else
    {
        my ($list1, $list2, $list3) = parse_input( @ARGV );

        printf "Input:  \@list1 = (%s)\n", join ', ', map { qq["$_"] } @$list1;
        printf "        \@list2 = (%s)\n", join ', ', map { qq["$_"] } @$list2;

        if (scalar @$list3 > 0)
        {
            printf "        \@list3 = (%s)\n", join ', ',
                map { '[' . join( ', ', map { qq["$_"] } @$_ ) . ']' } @$list3;
        }

        my $similar = are_similar( $list1, $list2, $list3 ) ? 'true' : 'false';

        print  "Output: $similar\n";
    }
}

#-------------------------------------------------------------------------------
sub are_similar
#-------------------------------------------------------------------------------
{
    my ($list1, $list2, $list3) = @_;

    return false unless scalar @$list1 == scalar @$list2;

    # Build a similar-words map

    my %similar_words;

    for my $list (@$list3)
    {
        for my $word (@$list)
        {
            push $similar_words{ $word }->@*, grep { $_ ne $word } @$list;
        }
    }

    L_OUTER: for my $i (0 .. $#$list1)
    {
        my $target    = $list1->[$i];
        my $candidate = $list2->[$i];

        next if $candidate eq $target;

        return false unless exists $similar_words{ $target };

        for my $word ($similar_words{ $target }->@*)
        {
            next L_OUTER if $candidate eq $word;
        }

        return false;
    }

    return true;
}

#-------------------------------------------------------------------------------
sub parse_input
#-------------------------------------------------------------------------------
{
    my ($list1, $list2, @list3) = @_;

    my @list1 = grep { length > 0 } split / \s+ /x, $list1;
    my @list2 = grep { length > 0 } split / \s+ /x, $list2;
    my @map;

    for my $str (@list3)
    {
        push @map, [ grep { length > 0 } split / \s+ /x, $str ];
    }

    return \@list1, \@list2, \@map;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $list1_str, $list2_str, $expected, @list3_strs) =
             split / \| /x, $line;

        for ($test_name, $list1_str, $list2_str, $expected, @list3_strs)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @lists   = parse_input( $list1_str, $list2_str, @list3_strs );
        my $similar = are_similar( @lists ) ? 'true' : 'false';

        is $similar, $expected, $test_name;
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
Example 1|great acting   |fine drama           |true |great fine |acting drama
Example 2|apple pie      |banana pie           |false|apple peach|peach banana
Example 3|perl4 python   |raku python          |true |perl4 perl5 raku
Example 4|enjoy challenge|love weekly challenge|false|enjoy love
Example 5|fast car       |quick vehicle        |true |quick fast |vehicle car
Identical|Perl Raku C++  |Perl Raku C++        |true
