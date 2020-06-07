use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 063
=========================

Task #2
-------
*Rotate String*

*Submitted by: Mohammad S Anwar*
*Reviewed by: Ryan Thompson*

Given a word made up of an arbitrary number of x and y characters, that word can
be rotated as follows: For the _i_th rotation (starting at _i_ = 1), _i_ %
length(_word_) characters are moved from the front of the string to the end.
Thus, for the string xyxx, the initial (_i_ = 1) % 4 = 1 character (x) is moved
to the end, forming yxxx. On the second rotation, (_i_ = 2) % 4 = 2 characters
(yx) are moved to the end, forming xxyx, and so on. See below for a complete
example.

Your task is to write a function that takes a string of xs and ys and returns
the minimum non-zero number of rotations required to obtain the original string.
You may show the individual rotations if you wish, but that is not required.

*Example*

Input: $word = 'xyxx';

 ▪ *Rotation 1:* you get yxxx by moving x to the end.
 ▪ *Rotation 2:* you get xxyx by moving yx to the end.
 ▪ *Rotation 3:* you get xxxy by moving xxy to the end.
 ▪ *Rotation 4:* you get xxxy by moving nothing as 4 % length(xyxx) == 0.
 ▪ *Rotation 5:* you get xxyx by moving x to the end.
 ▪ *Rotation 6:* you get yxxx by moving xx to the end.
 ▪ *Rotation 7:* you get xyxx by moving yxxx to the end which is same as the
                 given word.

Output: 7

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#-------------------------------------------------------------------------------
BEGIN ''.put;
#-------------------------------------------------------------------------------

#===============================================================================
sub MAIN
(
    Str:D   $word,                           #= string of 'x' and 'y' characters
    Bool:D :$show = False,                   #= display individual rotations
)
#===============================================================================
{
    "Challenge 063, Task #2: Rotate String (Raku)\n".put;

    "WARNING: Invalid character '$0' found in word '$word'\n".note
        if $word ~~ / ( <-[xy]> ) /;

    my UInt $count = find-rotations($word, $show);

    "Minimum rotations for '$word': $count".put;
}

#-------------------------------------------------------------------------------
sub find-rotations( Str:D $word, Bool:D $show --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt $length    = $word.chars;
    my Str  @chars     = $word.split: '', :skip-empty;
    my UInt $rotation  = 0;
    my Str  $rotd-word = $word;

    "Rotation $rotation: $rotd-word".put if $show;

    repeat until $rotd-word eq $word
    {
        my Str @chars-to-move;
               @chars-to-move.push: @chars.shift for 1 .. ++$rotation % $length;

        @chars.append: @chars-to-move;

        $rotd-word = @chars.join: '';

        "Rotation $rotation: $rotd-word".put if $show;
    }

    ''.put if $show;

    return $rotation;
}

################################################################################
