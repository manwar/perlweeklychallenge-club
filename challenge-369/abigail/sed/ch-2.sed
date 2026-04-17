#!/opt/homebrew/bin/gsed

#
# This program only works if the size does not exceed 9
#
# We obviously don't store the substrings in an array
#

#
# For each number 1 .. 9, we check whether this is the size. If so, we
# capture the filler character, then add the filler character one less
# times to the string. The size and filler character, and the separating
# space are removed. We then remove some of the filler characters so the
# resulting string has a length which is an integer times the size. Once
# trimmed, we put a space after each size characters. Finally (at label :e),
# we remove a trailing space.
#
    s/ 1 (.)$//;                  Tl2;  s/((.{1})+).*/\1/;  s/.{1}/& /g;  be;
:l2 s/ 2 (.)$/\1/;                Tl3;  s/((.{2})+).*/\1/;  s/.{2}/& /g;  be;
:l3 s/ 3 (.)$/\1\1/;              Tl4;  s/((.{3})+).*/\1/;  s/.{3}/& /g;  be;
:l4 s/ 4 (.)$/\1\1\1/;            Tl5;  s/((.{4})+).*/\1/;  s/.{4}/& /g;  be;
:l5 s/ 5 (.)$/\1\1\1\1/;          Tl6;  s/((.{5})+).*/\1/;  s/.{5}/& /g;  be;
:l6 s/ 6 (.)$/\1\1\1\1\1/;        Tl7;  s/((.{6})+).*/\1/;  s/.{6}/& /g;  be;
:l7 s/ 7 (.)$/\1\1\1\1\1\1/;      Tl8;  s/((.{7})+).*/\1/;  s/.{7}/& /g;  be;
:l8 s/ 8 (.)$/\1\1\1\1\1\1\1/;    Tl9;  s/((.{8})+).*/\1/;  s/.{8}/& /g;  be;
:l9 s/ 9 (.)$/\1\1\1\1\1\1\1\1/;  b;    s/((.{9})+).*/\1/;  s/.{9}/& /g;  be;

:e  s/ $//
