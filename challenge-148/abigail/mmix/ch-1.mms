%
% See https://theweeklychallenge.org/blog/perl-weekly-challenge-148
%

%
% Run as: mmixal -o ch-1.mmo ch-1.mms; mmix -q ch-1.mmo
%
        LOC     Data_Segment
        GREG    @
Text    BYTE    "2 4 6 30 32 34 36 40 42 44 46 "
        BYTE    "50 52 54 56 60 62 64 66",10,0

        LOC     #100

Main    LDA     $255,Text
        TRAP    0,Fputs,StdOut
        TRAP    0,Halt,0
