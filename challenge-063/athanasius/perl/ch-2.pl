#!perl

################################################################################
=comment

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

=cut
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;
use Getopt::Long;

const my $USAGE => "Usage:\n  perl $0 [--show] <word>\n\n"            .
                   "    <word>    string of 'x' and 'y' characters\n" .
                   "    --show    display individual rotations\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    print "Challenge 063, Task #2: Rotate String (Perl)\n\n";

    my $show = 0;

    GetOptions('show' => \$show) or die "\n" . $USAGE;
    scalar @ARGV == 1            or die        $USAGE;

    my $word = $ARGV[0];

    warn "WARNING: Invalid character '$1' found in word '$word'\n\n"
        if $word =~ / ([^xy]) /x;

    my $count = find_rotations($word, $show);

    print "Minimum rotations for '$word': $count\n";
}

#-------------------------------------------------------------------------------
sub find_rotations
#-------------------------------------------------------------------------------
{
    my ($word, $show) = @_;
    my  $length       = length    $word;
    my  @chars        = split //, $word;
    my  $rotation     = 0;
    my  $rotd_word    = $word;

    printf "Rotation %d: %s\n", $rotation, $rotd_word if $show;

    do
    {
        my   @chars_to_move;
        push @chars_to_move, shift @chars for 1 .. ++$rotation % $length;
        push @chars, @chars_to_move;

        $rotd_word = join '', @chars;

        printf "Rotation %d: %s\n", $rotation, $rotd_word if $show;

    } until ($rotd_word eq $word);

    print "\n" if $show;

    return $rotation;
}

################################################################################
