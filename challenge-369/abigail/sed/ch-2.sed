#!/opt/homebrew/bin/gsed

#
# This program only works if the size does not exceed 20
#
# We obviously don't store the substrings in an array
#

#
# For each number 1 .. 20, we check whether this is the size. If so, we
# capture the filler character, then add the filler character one less
# times to the string. The size and filler character, and the separating
# space are removed. We then remove some of the filler characters so the
# resulting string has a length which is an integer times the size. Once
# trimmed, we put a space after each size characters. Finally (at label :e),
# we remove a trailing space.
#

      s/ 1 (.)$//;                                        Tl2;  s/.{1}/& /g; be;
 :l2  s/ 2 (.)$/\1/;                                      Tl3;  s/.{2}/& /g; be;
 :l3  s/ 3 (.)$/\1\1/;                                    Tl4;  s/.{3}/& /g; be;
 :l4  s/ 4 (.)$/\1\1\1/;                                  Tl5;  s/.{4}/& /g; be;
 :l5  s/ 5 (.)$/\1\1\1\1/;                                Tl6;  s/.{5}/& /g; be;
 :l6  s/ 6 (.)$/\1\1\1\1\1/;                              Tl7;  s/.{6}/& /g; be;
 :l7  s/ 7 (.)$/\1\1\1\1\1\1/;                            Tl8;  s/.{7}/& /g; be;
 :l8  s/ 8 (.)$/\1\1\1\1\1\1\1/;                          Tl9;  s/.{8}/& /g; be;
 :l9  s/ 9 (.)$/\1\1\1\1\1\1\1\1/;                       Tl10;  s/.{9}/& /g; be;
:l10 s/ 10 (.)$/\1\1\1\1\1\1\1\1\1/;                     Tl11; s/.{10}/& /g; be;
:l11 s/ 11 (.)$/\1\1\1\1\1\1\1\1\1\1/;                   Tl12; s/.{11}/& /g; be;
:l12 s/ 12 (.)$/\1\1\1\1\1\1\1\1\1\1\1/;                 Tl13; s/.{12}/& /g; be;
:l13 s/ 13 (.)$/\1\1\1\1\1\1\1\1\1\1\1\1/;               Tl14; s/.{13}/& /g; be;
:l14 s/ 14 (.)$/\1\1\1\1\1\1\1\1\1\1\1\1\1/;             Tl15; s/.{14}/& /g; be;
:l15 s/ 15 (.)$/\1\1\1\1\1\1\1\1\1\1\1\1\1\1/;           Tl16; s/.{15}/& /g; be;
:l16 s/ 16 (.)$/\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1/;         Tl17; s/.{16}/& /g; be;
:l17 s/ 17 (.)$/\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1/;       Tl18; s/.{17}/& /g; be;
:l18 s/ 18 (.)$/\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1/;     Tl19; s/.{18}/& /g; be;
:l19 s/ 19 (.)$/\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1/;   Tl20; s/.{19}/& /g; be;
:l20 s/ 20 (.)$/\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1/; T;    s/.{20}/& /g; be;

:e  s/(.*) [^ ]*$/\1/
