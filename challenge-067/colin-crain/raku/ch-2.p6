#!/usr/bin/env perl6
#
#
#       hooked_on_phonics.raku
#
#         TASK #2 › Letter Phone
#         Submitted by: Mohammad S Anwar
#
#             You are given a digit string $S. Write a script to print all
#             possible letter combinations that the given digit string could
#             represent.
#
#             Letter Phone
#                 2  -->   ABC
#                 3  -->   DEF
#                 4  -->   GHI
#                 5  -->   JKL
#                 6  -->   MNO
#                 7  -->   PQRS
#                 8  -->   TUV
#                 9  -->   WXYZ
#
#
#             Example:
#               Input: $S = '35'
#
#               Output: ["dj", "dk", "dl", "ej", "ek", "el", "fj", "fk", "fl"].
#
#       2020 colin crain
#
# # # # # # # # # # # # # # # # # # #


sub MAIN ( Int $input = 527  ) {

   my @digits = $input.comb;

    my %encode = (  2  =>  ("a", "b", "c"),
                    3  =>  ("d", "e", "f"),
                    4  =>  ("g", "h", "i"),
                    5  =>  ("j", "k", "l"),
                    6  =>  ("m", "n", "o"),
                    7  =>  ("p", "q", "r", "s"),
                    8  =>  ("t", "u", "v"),
                    9  =>  ("w", "x", "y", "z")  );

    my @list = |%encode{@digits.shift};

    @list = make_strings(%encode, @digits, @list);
    .say for @list;

}

sub make_strings (%encode, @digits, @list) {
    return @list unless @digits.elems > 0;

    my @newlist;
    my $digit = @digits.shift;
    for @list -> $str {
        for ( %encode{$digit}.list ) {
            @newlist.push: $str ~ $_;
        }
    }
    return make_strings( %encode, @digits, @newlist);
}
