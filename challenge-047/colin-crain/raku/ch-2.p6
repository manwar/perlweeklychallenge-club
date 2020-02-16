use v6.d;

#
#       gapful.raku
#
#       PWC 47 - TASK #2
#       Gapful Number
#             Write a script to print first 20 Gapful Numbers greater than or
#             equal to 100. #   #Please check out the page for more information
#             about Gapful Numbers.
#
#                 A108343     Gapful numbers >= 100: numbers that are
#                   divisible by the number formed by their first and last
#                   digit. Numbers up to 100 trivially have this property
#                   and are excluded.
#
#                 100, 105, 108, 110, 120, 121, 130, 132, 135, 140, 143, 150,
#                 154, 160, 165, 170, 176, 180, 187, 190, 192, 195, 198, 200,
#                 220, 225, 231, 240, 242, 253, 260, 264, 275, 280, 286, 297,
#                 300, 315, 330, 341, 352, 360, 363, 374, 385, 390, 396, 400,
#                 405, 440, 451
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

sub MAIN () {

    ## this parses to literally exactly the definition of A108343 above; allow
    ## only numbers (starting at 100) "that are divisible by the number formed by
    ## their first and last digit"".

    my @o2 = (100..*).grep({ $_ %% (.comb.head ~ .comb.tail) });

    ## output creates the first required 20 elements of the lazy list
    say @o2[$_] for (0..19);

}
