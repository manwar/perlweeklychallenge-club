#!perl

################################################################################
=comment

Perl Weekly Challenge 212
=========================

TASK #1
-------
*Jumping Letters*

Submitted by: Mohammad S Anwar

You are given a word having alphabetic characters only, and a list of positive
integers of the same length

Write a script to print the new word generated after jumping forward each letter
in the given word by the integer in the list. The given list would have exactly
the number as the total alphabets in the given word.

Example 1

  Input: $word = 'Perl' and @jump = (2,22,19,9)
  Output: Raku

  'P' jumps 2 place forward and becomes 'R'.
  'e' jumps 22 place forward and becomes 'a'.
     (jump is cyclic i.e. after 'z' you go back to 'a')
  'r' jumps 19 place forward and becomes 'k'.
  'l' jumps 9 place forward and becomes 'u'.

Example 2

  Input: $word = 'Raku' and @jump = (24,4,7,17)
  Output: 'Perl'

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
If no command-line arguments are given, the test suite is run.

Note
----
Case is preserved in each jump.

=cut
#===============================================================================

use strict;
use warnings;
use Const::Fast;
use Devel::Assert  qw( on );
use Regexp::Common qw( number );
use Test::More;

const my $USAGE =>
"Usage:
  perl $0 <word> [<jump> ...]
  perl $0

    <word>          A non-empty word containing alphabetic characters only
    [<jump> ...]    A list of positive integers of the same length as \$word\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 212, Task #1: Jumping Letters (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $args = scalar @ARGV;

    if    ($args == 0)
    {
        run_tests();
    }
    elsif ($args == 1)
    {
        error( 'Expected 0 or 2+ command line arguments, found 1' );
    }
    else
    {
        my ($word, $jump) = parse_command_line();

        printf "Input:  \$word = '%s' and \@jump = (%s)\n",
                $word, join ', ', @$jump;

        printf "Output: '%s'\n",  jump_letters( $word, $jump );
    }
}

#-------------------------------------------------------------------------------
sub jump_letters
#-------------------------------------------------------------------------------
{
    my ($word, $jump) = @_;

    assert $word =~ / ^ [A-Za-z]+ $ /x;
    assert scalar @$jump == length $word;

    my $new_word = '';

    for my $i (0 .. $#$jump)
    {
        my $letter    = substr $word, $i, 1;
        my $is_uc     = ord( 'A' ) <= ord( $letter ) <= ord( 'Z' );
        my $offset    = ord( $is_uc ? 'A' : 'a' );
        my $value     = ord( $letter ) - $offset;
        my $new_value = ($value + $jump->[ $i ]) % 26;
           $new_word .= chr( $new_value + $offset );
    }

    return $new_word;
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my $word  = shift  @ARGV;
    my $chars = length $word;
    my $ints  = scalar @ARGV;

    $chars > 0      or error( 'Empty word' );
    $ints == $chars or error( "Expected $chars integers, found $ints" );

    for (@ARGV)
    {
        / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer]    );
        $_ > 0                 or error( qq["$_" is not a positive integer] );
    }

    return ($word, [ @ARGV ]);
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $word, $jump_str, $expected) = split / \| /x, $line;

        for ($test_name, $word, $jump_str)          # Trim whitespace
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @jump = split / , \s* /x, $jump_str;
        my $got  = jump_letters( $word, \@jump );

        is $got, $expected, $test_name;
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
Example 1 |Perl      | 2,22,19, 9               |Raku
Example 2 |Raku      |24, 4, 7,17               |Perl
One letter|B         |25                        |A
Me        |Imperlmonk|18, 7,18,22,22,15,6,20,7,8|Athanasius
