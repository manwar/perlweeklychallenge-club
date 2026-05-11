use v6d;

################################################################################
=begin comment

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

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

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

=end comment
#===============================================================================

use Test;

subset Lower of Str  where / ^ <:Ll        > $ /;
subset Input of Str  where / ^ <:Ll + [ ? ]> $ /;
subset Steps of List where (Int, Int);

my UInt constant $CODEPOINT1 = 'a'.ord;
my UInt constant $LETTERS    = 'z'.ord - $CODEPOINT1 + 1;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 371, Task #1: Missing Letter (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A sequence of 4 lowercase letters and one question mark

    *@seq where { .elems == 5 && .all ~~ Input:D && .one eq '?' }
)
#===============================================================================
{
    "Input:  \$seq = qw(%s)\n".printf: @seq.join: ' ';

    my Str $missing = find-missing-letter( @seq ) // '<none>';

    "Output: $missing".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-missing-letter
(
    List:D[Str:D] $seq where { .elems == 5 && .all ~~ Input:D && .one eq '?' }
--> Lower
)
#-------------------------------------------------------------------------------
{
    my UInt $missing = (0 .. 4).first: { $seq[$_] eq '?' };
    my UInt @nums    = $seq.map: { $_ eq '?' ?? 0
                                             !! ord( $_ ) - $CODEPOINT1 + 1 };

    my Int ($step1, $step2) = analyse-seq( @nums, $missing );

    return (@nums[0] == step( @nums[1], -$step1 ) &&
            @nums[1] == step( @nums[0],  $step1 ) &&
            @nums[2] == step( @nums[1],  $step2 ) &&
            @nums[3] == step( @nums[2],  $step1 ) &&
            @nums[4] == step( @nums[3],  $step2 )) ??
           (@nums[$missing] + $CODEPOINT1 - 1).chr !! Nil;
}

#-------------------------------------------------------------------------------
sub analyse-seq
(
    List:D[UInt:D] $nums,
    UInt:D         $missing where 0 <= * <= 4
--> Steps:D
)
#-------------------------------------------------------------------------------
{
    my Int ($step1, $step2);

    if     $missing == 0
    {
        $step1   = ($nums[3] - $nums[2]) % $LETTERS;
        $step2   = ($nums[4] - $nums[3]) % $LETTERS;
        $nums[0] = step( $nums[1], -$step1 );
    }
    elsif  $missing == 1
    {
        $step1   = ($nums[3] - $nums[2]) % $LETTERS;
        $step2   = ($nums[4] - $nums[3]) % $LETTERS;
        $nums[1] = step( $nums[0],  $step1 );
    }
    elsif  $missing == 2
    {
        $step1   = ($nums[1] - $nums[0]) % $LETTERS;
        $step2   = ($nums[4] - $nums[3]) % $LETTERS;
        $nums[2] = step( $nums[1],  $step2 );
    }
    elsif  $missing == 3
    {
        $step1   = ($nums[1] - $nums[0]) % $LETTERS;
        $step2   = ($nums[2] - $nums[1]) % $LETTERS;
        $nums[3] = step( $nums[2],  $step1 );
    }
    else # $missing == 4
    {
        $step1   = ($nums[1] - $nums[0]) % $LETTERS;
        $step2   = ($nums[2] - $nums[1]) % $LETTERS;
        $nums[4] = step( $nums[3],  $step2 );
    }

    return $step1, $step2;
}

#-------------------------------------------------------------------------------
sub step( UInt:D $start where 0 < * <= $LETTERS, Int:D $step --> UInt:D )
#-------------------------------------------------------------------------------
{
    return (($start + $step - 1) % $LETTERS) + 1;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $seq-str, $expected) = $line.split: / \| /;

        for     $test-name, $seq-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str @seq     = $seq-str.split: / \s+ /, :skip-empty;
        my Str $missing = find-missing-letter( @seq ) // '<none>';

        is $missing, $expected, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub test-data( --> Str:D )
#-------------------------------------------------------------------------------
{
    return q:to/END/;
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
        END
}

################################################################################
