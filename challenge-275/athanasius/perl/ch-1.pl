#!perl

################################################################################
=comment

Perl Weekly Challenge 275
=========================

TASK #1
-------
*Broken Keys*

Submitted by: Mohammad Sajid Anwar

You are given a sentence, $sentence and list of broken keys @keys.

Write a script to find out how many words can be typed fully.

Example 1

  Input: $sentence = "Perl Weekly Challenge", @keys = ('l', 'a')
  Output: 0

Example 2

  Input: $sentence = "Perl and Raku", @keys = ('a')
  Output: 1

  Only Perl since the other word two words contain 'a' and can't be typed fully.

Example 3

  Input: $sentence = "Well done Team PWC", @keys = ('l', 'o')
  Output: 2

Example 4

  Input: $sentence = "The joys of polyglottism", @keys = ('T')
  Output: 2

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
-----------

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. 

=cut
#===============================================================================

use v5.32.1;      # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my %TWIN_KEYS =>
( 
    '`' => '~',  1  => '!',  2  => '@',  3   => '#',  4  => '$', 5   => '%',
     6  => '^',  7  => '&',  8  => '*',  9   => '(',  0  => ')', '-' => '_',
    '=' => '+', '[' => '{', ']' => '}', '\\' => '|', ';' => ':', "'" => '"',
    ',' => '<', '.' => '>', '/' => '?'
);
const my %TWIN  => %TWIN_KEYS, reverse %TWIN_KEYS;
const my $USAGE => <<END;
Usage:
  perl $0 <sentence> <broken-keys>
  perl $0

    <sentence>       A sentence
    <broken-keys>    A string comprising a list of broken keys
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 275, Task #1: Broken Keys (Perl)\n\n";
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
    elsif ($argc == 2)
    {
        my ($sentence, $broken_keys) = @ARGV;
        my  @keys = split //, $broken_keys;

        printf qq[Input:  \$sentence = "%s", \@keys = (%s)\n],
               $sentence, join ', ', map { qq['$_'] } @keys;

        my $count = can_be_typed( $sentence, \@keys );

        print "Output: $count\n";
    }
    else
    {
        error( "Expected 0 or 2 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub can_be_typed
#-------------------------------------------------------------------------------
{
    my ($sentence, $keys) = @_;
    my  $count            = 0;
    my  @words            = split / \s+ /x, $sentence;
    my  @broken_keys      = @$keys;

    for my $key (@$keys)
    {
        push @broken_keys, $TWIN{ $key } if exists $TWIN{ $key };
    }

    my $re_str = join '|', map { "\Q$_\E" } @broken_keys;
    my $broken = qr/ $re_str /ix;

    for my $word (@words)
    {
        ++$count if $word =~ / \w /x && $word !~ $broken;
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

        my  ($test_name, $sentence, $keys_str, $expected) =
             split / \| /x, $line;

        for ($test_name, $sentence, $keys_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @keys  = split //, $keys_str;
        my $count = can_be_typed( $sentence, \@keys );

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
Example 1  |Perl Weekly Challenge   |la|0
Example 2  |Perl and Raku           |a |1
Example 3  |Well done Team PWC      |lo|2
Example 4  |The joys of polyglottism|T |2
Twin keys 1|Perl1 Weekly@ Challenge |!2|1
Twin keys 2|Perl! Weekly2 Challenge |@1|1
