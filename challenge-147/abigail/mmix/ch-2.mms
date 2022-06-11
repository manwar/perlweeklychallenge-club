%
% See https://theweeklychallenge.org/blog/perl-weekly-challenge-147
%

%
% Run as: mmixal -o ch-2.mmo ch-2.mms; mmix -q ch-2.mmo
%
        LOC     Data_Segment
        GREG    @
Text    BYTE    "1560090 7042750",10,0

        LOC     #100

Main    LDA     $255,Text
        TRAP    0,Fputs,StdOut
        TRAP    0,Halt,0
