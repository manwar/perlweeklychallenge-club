#!perl

################################################################################
=comment

Perl Weekly Challenge 371
=========================

TASK #1
-------
*Missing Letter*

Submitted by: Reinier Maliepaard

You are given a sequence of 5 lowercase letters, with one letter replaced by
'?'. Each letter maps to its position in the alphabet ('a = 1', 'b = 2', ...,
'z = 26'). The sequence follows a repeating pattern of step sizes between con-
secutive letters. The pattern is either a constant step (e.g., '+2, +2, +2, +2')
or a simple alternating pattern of two distinct steps (e.g., '+2, +3, +2, +3').

Example 1

  Input: $seq = qw(a c ? g i)
  Output: e

  The pattern of the sequence is +2,+2,+2,+2.
  1: a
  3: c
  5: e
  7: g
  9: i

Example 2

  Input: $seq = qw(a d ? j m)
  Output: g

  The pattern of the sequence is +3,+3,+3,+3.
  1: a
  4: d
  7: g
  10: j
  13: m

Example 3

  Input: $seq = qw(a e ? m q)
  Output: i

  The pattern of the sequence is +4,+4,+4,+4.
  1: a
  5: e
  9: i
  13: m
  17: q

Example 4

  Input: $seq = qw(a c f ? k)
  Output: h

  The pattern of the sequence is +2,+3,+2,+3.
  1: a
  3: c
  6: f
  8: h
  11: k

Example 5

  Input: $seq = qw(b e g ? l)
  Output: j

  The pattern of the sequence is +3,+2,+3,+2.
  2: b
  5: e
  7: g
  10: j
  12: l

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
2. A sequence of five characters is entered on the command-line. Four of the
   characters are lowercase letters, and one is a question mark.

Assumptions
-----------
1. The "?" character may appear in any position within the input sequence.
2. Step sizes are integers. They may be negative or zero.
3. The alphabet "wraps" from "z" to "a" (and vice versa). So, for example, in
   the sequence qw(t v x z ?), the step is +2 and the missing letter is "b".

=cut
#===============================================================================

use v5.38.2;   # Enables strictures
use warnings;
use Const::Fast;
use List::Util qw( first );
use Test::More;

const my $CODEPOINT1 => ord( 'a' );
const my $LETTERS    => ord( 'z' ) - $CODEPOINT1 + 1;
const my $USAGE      => <<END;
Usage:
  perl $0 [<seq> ...]
  perl $0

    [<seq> ...]    A sequence of 4 lowercase letters and one question mark
END
#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 371, Task #1: Missing Letter (Perl)\n\n";
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
    elsif ($argc == 5)
    {
        my @seq = @ARGV;

        validate_input( \@seq );

        printf "Input:  \$seq = qw(%s)\n", join ' ', @seq;

        my $missing = find_missing_letter( \@seq );

        printf "Output: %s\n", $missing // '<none>';
    }
    else
    {
        error( "Expected 0 or 5 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_missing_letter
#-------------------------------------------------------------------------------
{
    my ($seq)    = @_;
    my  $missing = first { $seq->[$_] eq '?' } 0 .. 4;
    my  @nums    = map { $_ eq '?' ? 0 : ord() - $CODEPOINT1 + 1 } @$seq;

    my ($step1, $step2) = analyse_seq( \@nums, $missing );

    return ($nums[0] == step( $nums[1], -$step1 ) &&
            $nums[1] == step( $nums[0],  $step1 ) &&
            $nums[2] == step( $nums[1],  $step2 ) &&
            $nums[3] == step( $nums[2],  $step1 ) &&
            $nums[4] == step( $nums[3],  $step2 )) ?
       chr( $nums[$missing] + $CODEPOINT1 - 1 )    : undef;
}

#-------------------------------------------------------------------------------
sub analyse_seq
#-------------------------------------------------------------------------------
{
    my ($nums,  $missing) = @_;
    my ($step1, $step2);

    if    ($missing == 0)
    {
        $step1     = ($nums->[3] - $nums->[2]) % $LETTERS;
        $step2     = ($nums->[4] - $nums->[3]) % $LETTERS;
        $nums->[0] = step( $nums->[1], -$step1 );
    }
    elsif ($missing == 1)
    {
        $step1     = ($nums->[3] - $nums->[2]) % $LETTERS;
        $step2     = ($nums->[4] - $nums->[3]) % $LETTERS;
        $nums->[1] = step( $nums->[0],  $step1 );
    }
    elsif ($missing == 2)
    {
        $step1     = ($nums->[1] - $nums->[0]) % $LETTERS;
        $step2     = ($nums->[4] - $nums->[3]) % $LETTERS;
        $nums->[2] = step( $nums->[1],  $step2 );
    }
    elsif ($missing == 3)
    {
        $step1     = ($nums->[1] - $nums->[0]) % $LETTERS;
        $step2     = ($nums->[2] - $nums->[1]) % $LETTERS;
        $nums->[3] = step( $nums->[2],  $step1 );
    }
    elsif ($missing == 4)
    {
        $step1     = ($nums->[1] - $nums->[0]) % $LETTERS;
        $step2     = ($nums->[2] - $nums->[1]) % $LETTERS;
        $nums->[4] = step( $nums->[3],  $step2 );
    }
    else
    {
        die "Impossible case: \$missing = $missing, stopped";
    }

    return ($step1, $step2);
}

#-------------------------------------------------------------------------------
sub step
#-------------------------------------------------------------------------------
{
    my ($start, $step) = @_;

    return (($start + $step - 1) % $LETTERS) + 1;
}

#-------------------------------------------------------------------------------
sub validate_input
#-------------------------------------------------------------------------------
{
    my ($seq) = @_;
    my  $qm   = 0;

    for my $letter (@$seq)
    {
        if ($letter eq '?')
        {
            ++$qm;
        }
        else
        {
            $letter =~ / ^ [a-z] $ /x
                or error( qq[Invalid letter "$letter"] );
        }
    }

    $qm == 1    or error( "Expected 1 question mark, found $qm" );
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $seq_str, $expected) =
             split / \| /x, $line;

        for ($test_name, $seq_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @seq = split / \s+ /x, $seq_str;

        validate_input( \@seq );

        my $missing = find_missing_letter( \@seq ) // '<none>';

        is $missing, $expected, $test_name;
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
Example 1  |a c ? g i|e
Example 2  |a d ? j m|g
Example 3  |a e ? m q|i
Example 4  |a c f ? k|h
Example 5  |b e g ? l|j
Invalid    |a b d x ?|<none>
Wrap end   |t v y ? d|a
Wrap start |w a b f ?|g
Zero step  |q ? q q q|q
Neg steps 1|p n m ? j|k
Neg steps 2|e c b ? y|z
Mixed steps|a ? c g e|e
