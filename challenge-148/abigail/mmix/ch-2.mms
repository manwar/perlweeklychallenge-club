%
% See https://theweeklychallenge.org/blog/perl-weekly-challenge-148
%

%
% Run as: mmixal -o ch-2.mmo ch-2.mms; mmix -q ch-2.mmo
%
        LOC     Data_Segment
        GREG    @
Text    BYTE    "2 1 5",10
        BYTE    "5 2 13",10
        BYTE    "8 3 21",10
        BYTE    "17 18 5",10
        BYTE    "11 4 29",10,0

        LOC     #100

Main    LDA     $255,Text
        TRAP    0,Fputs,StdOut
        TRAP    0,Halt,0
