#!perl

################################################################################
=comment

Perl Weekly Challenge 221
=========================

TASK #1
-------
*Good Strings*

Submitted by: Mohammad S Anwar

You are given a list of @words and a string $chars.

    A string is good if it can be formed by characters from $chars, each char-
    acter can be used only once.

Write a script to return the sum of lengths of all good strings in words.

Example 1

  Input: @words = ("cat", "bt", "hat", "tree")
         $chars = "atach"
  Output: 6

  The good strings that can be formed are "cat" and "hat" so the answer is
  3 + 3 = 6.

Example 2

  Input: @words = ("hello", "world", "challenge")
         $chars = "welldonehopper"
  Output: 10

  The strings that can be formed are "hello" and "world" so the answer is
  5 + 5 = 10.

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
2. If $CASE-SENSITIVE is set to a false value (the default), upper- and lower-
   case versions of the same letter (e.g., "A" and "a") are treated as equiva-
   lent; otherwise, they are treated as different characters.
3. If $VERBOSE is set to a true value (the default), the output is followed by
   a list of the "good strings".

=cut
#===============================================================================

use strict;
use warnings;
use Const::Fast;
use Test::More;

const my $CASE_SENSITIVE => 0;
const my $VERBOSE        => 1;
const my $USAGE          =>
"Usage:
  perl $0 <chars> [<words> ...]
  perl $0

    <chars>          A string of characters
    [<words> ...]    A non-empty list of non-empty strings\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 221, Task #1: Good Strings (Perl)\n\n";
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
        my ($chars, $words) = parse_command_line();

        printf qq[Input:  \@words = (%s)\n],
               join ', ', map { qq["$_"] } @$words;
        print  qq[        \$chars = "$chars"\n];

        my $strings = find_good_strings( $words, $chars );
        my $sum     = find_total_length( $strings );

        print "Output: $sum\n";

        if ($VERBOSE && scalar @$strings > 0)
        {
            if (scalar @$strings == 1)
            {
                printf qq[\nThe good string is "%s"\n], $strings->[ 0 ];
            }
            else
            {
                printf qq[\nThe good strings are %s\n],
                       join ', ', map { qq["$_"] } @$strings;
            }
        }
    }
}

#-------------------------------------------------------------------------------
sub find_good_strings
#-------------------------------------------------------------------------------
{
    my ($words, $chars) = @_;

    my  @chars = split //, $chars;
        @chars = map { lc } @chars unless $CASE_SENSITIVE;
    my  %pool;
      ++$pool{ $_ } for @chars;
    my  @good_strings;

    for my $word (@$words)
    {
        my @letters = split //, $word;
           @letters = map { lc } @letters unless $CASE_SENSITIVE;
        my %target;
         ++$target{ $_ } for @letters;

        push @good_strings, $word if is_subset( \%target, \%pool );
    }

    return \@good_strings;
}

#-------------------------------------------------------------------------------
sub is_subset
#-------------------------------------------------------------------------------
{
    my ($lhs, $rhs) = @_;

    for (keys %$lhs)
    {
        return 0 if !exists $rhs->{ $_ } || $lhs->{ $_ } > $rhs->{ $_ };
    }

    return 1;
}

#-------------------------------------------------------------------------------
sub find_total_length
#-------------------------------------------------------------------------------
{
    my ($strings) = @_;
    my  $total    = 0;
        $total   += length for @$strings;

    return $total;
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    scalar @ARGV >= 2
               or error( 'Expected 0 or 2+ command-line arguments, found 1' );

    my $chars = $ARGV[ 0 ];
    my @words = @ARGV[ 1 .. $#ARGV ];

    length > 0 or error( 'Empty string in list of words' ) for @words;

    return ($chars, \@words);
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($name, $chars, $words, $exp_sum, $exp_words) = split /\|/, $line;

        for ($name, $chars, $words, $exp_sum, $exp_words)      # Trim whitespace
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @expected = split / \s+ /x, $exp_words;
        my @words    = split / \s+ /x, $words;
        my $strings  = find_good_strings( \@words, $chars );
        my $sum      = find_total_length( $strings );

        is        $sum,      $exp_sum,  $name;
        is_deeply $strings, \@expected, $name if $VERBOSE;
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
Example 1|atach         |cat bt hat tree      | 6|cat hat
Example 2|welldonehopper|hello world challenge|10|hello world
