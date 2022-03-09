%
% See https://theweeklychallenge.org/blog/perl-weekly-challenge-155
%

%
% Run as: mmixal -o ch-2.mmo ch-2.mms; mmix -q ch-2.mmo
%
        LOC     Data_Segment
        GREG    @
Text    BYTE    "8",10,0

        LOC     #100

Main    LDA     $255,Text
        TRAP    0,Fputs,StdOut
        TRAP    0,Halt,0
