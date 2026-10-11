#!perl

################################################################################
=comment

Perl Weekly Challenge 394
=========================

TASK #2
-------
*Alternating Vowels Consonants*

Submitted by: Mohammad Sajid Anwar

You are given three strings containing English alphabetic characters.

Find all the longest contiguous substrings common to all three strings that
strictly alternate between vowels and consonants.

Example 1

  Input: @str = ("relocate", "delocate", "allocate")
  Output: ("locate")

Example 2

  Input: @str = ("apple", "banana", "cherry")
  Output: ()

Example 3

  Input: @str = ("navigate", "cavity", "gravity")
  Output: ("avi")

Example 4

  Input: @str = ("pedalgia", "pedalboard", "pedantic")
  Output: ("peda")

Example 5

  Input: @strings = ("schoolmaster", "schoolhouse", "schooling")
  Output: ("ho", "ol")

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
2. Three strings, each containing letters from the English alphabet only, are
   entered on the command-line.

=cut
#===============================================================================

use v5.38.2;        # Enables strictures
use warnings;
use Const::Fast;
use List::Util      qw( all any );
use Test::More;

const my $ALPHA  => qr( ^ [A-Za-z]* $ )x;
const my @VOWELS => qw( A a E e I i O o U u );
const my $USAGE  => <<END;
Usage:
  perl $0 [<str> ...]
  perl $0

    [<str> ...]    3 strings containing letters from the English alphabet only
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 394, Task #2: Alternating Vowels Consonants (Perl)\n\n";
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
    elsif ($argc == 3)
    {
        my @str = @ARGV;

        for (@str)
        {
            /$ALPHA/ or error( qq["$_" is not a valid input string] );
        }

        printf "Input:  \@str = (%s)\n", join ', ', map { qq["$_"] } @str;

        my $substrs = find_longest_substrs( \@str );

        printf "Output: (%s)\n",         join ', ', map { qq["$_"] } @$substrs;
    }
    else
    {
        error( "Expected 0 or 3 arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_longest_substrs
#-------------------------------------------------------------------------------
{
    my ($str) = @_;
    my  @substrs;

    scalar @$str == 3 && all { /$ALPHA/ } @$str
        or die 'Invalid arguments, stopped';

    my ($s1, $s2, $s3) = sort { length $a <=> length $b || $a cmp $b } @$str;
    my  $candidates    = find_candidates( $s1 );

    for my $candidate (@$candidates)
    {
        my $cand_len = length $candidate;

        last if scalar @substrs > 0 && $cand_len < length $substrs[0];

        for my $i (0 .. $cand_len - 1)
        {
            for my $j (reverse( $i + 1 .. $cand_len ))
            {
                my $substr = substr $candidate, $i, $j - $i;

                record_substr( \@substrs, $substr )
                    if $s2 =~ / $substr /x && $s3 =~ / $substr /x;
            }
        }
    }

    return [ sort { $a cmp $b } @substrs ];
}

#-------------------------------------------------------------------------------
sub find_candidates
#-------------------------------------------------------------------------------
{
    my ($s1)     = @_;
    my  $pattern = $s1 =~ s/ (.) / (any { $1 eq $_ } @VOWELS) ? 'V' : 'C' /egrx;
    my  @candidates;

    while ($pattern =~ / ( C? (?:V C)* V? ) /gx)
    {
        push @candidates, substr $s1, $-[1], $+[1] - $-[1] if length $1 > 0;
    }

    return [ sort { length $b <=> length $a || $a cmp $b } @candidates ];
}

#-------------------------------------------------------------------------------
sub record_substr
#-------------------------------------------------------------------------------
{
    my ($substrs, $substr) = @_;

    if (scalar @$substrs == 0)
    {
        push @$substrs, $substr;
    }
    else
    {
        my $sub_len = length $substr;
        my $max_len = length $substrs->[0];

        if    ($sub_len >  $max_len)
        {
            @$substrs = $substr;
        }
        elsif ($sub_len == $max_len)
        {
            push @$substrs, $substr;
        }
    }
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    say 'Running the test suite';

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $str1, $str2, $str3, @expected) = split / \| /x, $line;

        for ($test_name, $str1, $str2, $str3, @expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $substrs = find_longest_substrs( [ $str1, $str2, $str3 ] );

        is_deeply $substrs, \@expected, $test_name;
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
Example 1       |relocate    |delocate   |allocate  |locate
Example 2       |apple       |banana     |cherry
Example 3       |navigate    |cavity     |gravity   |avi
Example 4       |pedalgia    |pedalboard |pedantic  |peda
Example 5       |schoolmaster|schoolhouse|schooling |ho    |ol
2 sub-candidates|ababcdededed|edededabab |ababededed|ededed
