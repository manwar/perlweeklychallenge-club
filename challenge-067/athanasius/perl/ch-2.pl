#!perl

################################################################################
=comment

Perl Weekly Challenge 067
=========================

Task #2
-------
*Letter Phone*

*Submitted by:* Mohammad S Anwar

You are given a digit string $S. Write a script to print all possible letter
combinations that the given digit string could represent.

<Letter Phone>

╭────────────────────────────────────╮
⎪ ╭────────╮  ╭────────╮  ╭────────╮ ⎪
⎪ ⎪ 1  _,@ ⎪  ⎪ 2  ABC ⎪  ⎪ 3  DEF ⎪ ⎪
⎪ ╰────────╯  ╰────────╯  ╰────────╯ ⎪
⎪ ╭────────╮  ╭────────╮  ╭────────╮ ⎪
⎪ ⎪ 4  GHI ⎪  ⎪ 5  JKL ⎪  ⎪ 6  MNO ⎪ ⎪
⎪ ╰────────╯  ╰────────╯  ╰────────╯ ⎪
⎪ ╭────────╮  ╭────────╮  ╭────────╮ ⎪
⎪ ⎪ 7 PQRS ⎪  ⎪ 8  TUV ⎪  ⎪ 9 WXYZ ⎪ ⎪
⎪ ╰────────╯  ╰────────╯  ╰────────╯ ⎪
⎪ ╭────────╮  ╭────────╮  ╭────────╮ ⎪
⎪ ⎪ *  ⸤_⸥ ⎪  ⎪ 0      ⎪  ⎪ #      ⎪ ⎪
⎪ ╰────────╯  ╰────────╯  ╰────────╯ ⎪
╰────────────────────────────────────╯

*Example:*

  Input: $S = '35'

  Output: ["dj", "dk", "dl", "ej", "ek", "el", "fj", "fk", "fl"].

=cut
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#*******************************************************************************
# Assumptions/interpretations:
#
# (1) "Letters" include the characters corresponding to keys "1" and "*"
# (2) The characters corresponding to key "1" are: underscore, comma, and the
#     "at" symbol
# (3) The character corresponding to the key "*" is a (single) space
# (4) The "0" and "#" keys are allowed as "digits" in the input digit string,
#     but -- as no characters correspond to them -- they are ignored in produc-
#     ing the possible output letter combinations
#*******************************************************************************

use strict;
use warnings;
use Algorithm::Loops qw( NestedLoops );
use Const::Fast;

const my $USAGE =>
"Usage:
  perl $0 <S>

    <S>    String of phone digits (0..9, *, #)\n";

const my %LETTERS =>
(
    1  => [ '_', ',', '@' ],
    2  => [ qw( A B C   ) ],
    3  => [ qw( D E F   ) ],
    4  => [ qw( G H I   ) ],
    5  => [ qw( J K L   ) ],
    6  => [ qw( M N O   ) ],
    7  => [ qw( P Q R S ) ],
    8  => [ qw( T U V   ) ],
    9  => [ qw( W X Y Z ) ],
   '*' => [ ' '           ],
    0  => [               ],
   '#' => [               ],
);

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
    print "Challenge 067, Task #2: Letter Phone (Perl)\n\n";

    my $digits = parse_command_line();
    my @loops;

    for my $digit (@$digits)
    {
        my   @letters = $LETTERS{ $digit }->@*;
        push @loops, \@letters if scalar @letters > 0;
    }

    my @combinations;

    NestedLoops
    (
        \@loops,
        sub
        {
            push @combinations, sprintf '"%s"', join '', map { lc $_ } @_;
        },
    );

    printf "[%s]\n", join ', ', @combinations;
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    scalar @ARGV == 1   or die $USAGE;

    my @digits = split '', $ARGV[0];

    scalar @digits > 0  or die $USAGE;

    exists $LETTERS{$_} or die $USAGE for @digits;

    return \@digits;
}

################################################################################
