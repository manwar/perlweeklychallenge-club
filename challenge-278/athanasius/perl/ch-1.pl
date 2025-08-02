#!perl

################################################################################
=comment

Perl Weekly Challenge 278
=========================

TASK #1
-------
*Sort String*

Submitted by: Mohammad Sajid Anwar

You are given a shuffle string, $str.

Write a script to return the sorted string.

    A string is shuffled by appending word position to each word.

Example 1

  Input: $str = "and2 Raku3 cousins5 Perl1 are4"
  Output: "Perl and Raku are cousins"

Example 2

  Input: $str = "guest6 Python1 most4 the3 popular5 is2 language7"
  Output: "Python is the most popular guest language"

Example 3

  Input: $str = "Challenge3 The1 Weekly2"
  Output: "The Weekly Challenge"

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
2. A "shuffle[d] string" is entered as a single argument on the command-line.

=cut
#===============================================================================

use v5.32.1;       # Enables strictures
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <str>
  perl $0

    <str>    Shuffled string in which each word has its position appended
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 278, Task #1: Sort String (Perl)\n\n";
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
        my $str = $ARGV[ 0 ];

        print qq[Input: \$str = "$str"\n];

        my $sorted = sort_sentence( $str );

        print qq[Output:       "$sorted"\n];
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub sort_sentence
#-------------------------------------------------------------------------------
{
    my ($str)   = @_;
    my  @words  = split / \s+ /x, $str;
    my  @sorted = (undef) x scalar @words;

    for my $shuffle_word (@words)
    {
        $shuffle_word =~ / ^ ( .* \D ) ( \d+ ) $ /x
            or  error( qq[\n"$shuffle_word" is not a valid shuffle word] );

        my ($word, $ord) = ($1, $2);

        $ord =~ / ^ $RE{num}{int} $ /x
            or  error( qq["$shuffle_word" does not end in a valid integer] );

        $ord > 0
            or  error( qq["$shuffle_word" does not end in a positive integer] );

        defined $sorted[ $ord ]
            and error( "Duplicate position $ord found" );

        $sorted[ $ord ] = $word;
    }

    for my $i (1 .. $#sorted)
    {
        defined $sorted[ $i ]
            or  error( "No word found for position $i" );
    }

    return join ' ', @sorted[ 1 .. $#sorted ];
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

        my  ($test_name, $str, $expected) = split / \| /x, $line;

        for ($test_name, $str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $sorted = sort_sentence( $str );

        is $sorted, $expected, $test_name;
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
Example 1|and2 Raku3 cousins5 Perl1 are4|Perl and Raku are cousins
Example 2|guest6 Python1 most4 the3 popular5 is2 language7                     \
         |Python is the most popular guest language
Example 3|Challenge3 The1 Weekly2|The Weekly Challenge
