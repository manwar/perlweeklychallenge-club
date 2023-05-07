#!perl

################################################################################
=comment

Perl Weekly Challenge 215
=========================

TASK #1
-------
*Odd One Out*

Submitted by: Mohammad S Anwar

You are given a list of words (alphabetic characters only) of same size.

Write a script to remove all words not sorted alphabetically and print the
number of words in the list that are not alphabetically sorted.

Example 1

  Input: @words = ('abc', 'xyz', 'tsu')
  Output: 1

  The words 'abc' and 'xyz' are sorted and can't be removed.
  The word 'tsu' is not sorted and hence can be removed.

Example 2

  Input: @words = ('rat', 'cab', 'dad')
  Output: 3

  None of the words in the given list are sorted.
  Therefore all three needs to be removed.

Example 3

  Input: @words = ('x', 'y', 'z')
  Output: 0

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
2. If $VERBOSE is set to a true value (the default), the output is followed by a
   breakdown of the sorted and unsorted words.

Assumptions
-----------
1. "Alphabetic characters" are A-Z and a-z only.
2. "Sorted alphabetically" means sorted in monotonically ascending alphabetical
   order.
3. Treatment of uppercase letters:
   a. If the constant $ASCIIBETICAL is set to a true value, uppercase letters
      rank below lowercase letters; so, e.g., "Bade" IS alphabetically sorted.
   b. Otherwise (the default), each uppercase letter is considered identical to
      its lowercase counterpart; so, "Bade" is equivalent to "bade", which is
      NOT alphabetically sorted.

=cut
#===============================================================================

use strict;
use warnings;
use Const::Fast;
use Test::More;

const my $ASCIIBETICAL => 0;
const my $VERBOSE      => 1;
const my $USAGE        =>
"Usage:
  perl $0 [<words> ...]
  perl $0

    [<words> ...]    Non-empty list of same-size words (chars A-Z and a-z only)
";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 215, Task #1: Odd One Out (Perl)\n\n";
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
        my $words = parse_command_line();

        printf "Input:  \@words = (%s)\n", join ', ', @$words;

        my ($sorted, $unsorted) = partition( $words );

        print  "Sorting ASCIIbetically...\n" if $ASCIIBETICAL;

        printf "Output: %d\n", scalar @$unsorted;

        if ($VERBOSE)
        {
            printf "\nSorted:   (%s)\n", join ', ', map { qq['$_'] } @$sorted;
            printf "Unsorted: (%s)\n",   join ', ', map { qq['$_'] } @$unsorted;
        }
    }
}

#-------------------------------------------------------------------------------
sub partition
#-------------------------------------------------------------------------------
{
    my ($words) = @_;
    my (@sorted, @unsorted);

    for my $word (@$words)
    {
        my $sorted   = 1;
        my $previous = '';

        for (split //, $word)
        {
            my  $letter = $ASCIIBETICAL ? $_ : lc;

            if ($letter lt $previous)
            {
                $sorted = 0;
                last;
            }

            $previous = $letter;
        }

        push @{ $sorted ? \@sorted : \@unsorted }, $word;
    }

    return (\@sorted, \@unsorted);
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my $first = $ARGV[ 0 ];

    for (@ARGV)
    {
        length == length $first
            or error( 'The input words are not all of the same size' );
    }

    return \@ARGV;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $words, $expected) = split / \| /x, $line;

        SKIP:
        {
            skip 'This test requires $ASCIIBETICAL to be False'
                if $ASCIIBETICAL && $test_name =~ / case /x;

            s/ \s+ $ //x for $test_name, $words;       # Trim whitespace

            my  @words              = split / , /x, $words;
            my ($sorted, $unsorted) = partition( \@words );

            is scalar( @$unsorted ), $expected, $test_name;
        }
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
Example 1 |abc,xyz,tsu                 |1
Example 2 |rat,cab,dad                 |3
Example 3 |x,y,z                       |0
Repeats   |beet,allow,abbot,boot,redder|1
Capitals  |ABC,XYZ,TSU                 |1
Mixed case|Bade,abcd,Abcd              |1
