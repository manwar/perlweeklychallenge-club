use v6d;

################################################################################
=begin comment

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

=end comment
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

subset DigitStr of Str where * ~~ / ^ <[ 0 .. 9 * # ]>+ $ /;

constant %LETTERS =
{
    1  => [ < _ , @   > ],
    2  => [ < A B C   > ],
    3  => [ < D E F   > ],
    4  => [ < G H I   > ],
    5  => [ < J K L   > ],
    6  => [ < M N O   > ],
    7  => [ < P Q R S > ],
    8  => [ < T U V   > ],
    9  => [ < W X Y Z > ],
   '*' => [ ' '         ],
    0  => [             ],
   '#' => [             ],
};

#-------------------------------------------------------------------------------
BEGIN ''.put;
#-------------------------------------------------------------------------------

#===============================================================================
sub MAIN
(
    DigitStr:D $S,                        #= String of phone digits (0..9, *, #)
)
#===============================================================================
{
    "Challenge 067, Task #2: Letter Phone (Raku)\n".put;

    my DigitStr @digits = $S.split: '', :skip-empty;
    my Str      @combinations;

    for @digits -> DigitStr $digit
    {
        my Str @letters = %LETTERS{ $digit }.list;

        if @letters.elems > 0
        {
            if @combinations.elems == 0
            {
                @combinations.push: .lc for @letters;
            }
            else
            {
                my Str @temp-array;

                for @combinations -> Str $combination
                {
                    @temp-array.push: $combination ~ .lc for @letters;
                }

                @combinations = @temp-array;
            }
        }
    }

    "[%s]\n".printf: @combinations.map({ qq["$_"] }).join: ', ';
}

#-------------------------------------------------------------------------------
sub USAGE()
#-------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

################################################################################
