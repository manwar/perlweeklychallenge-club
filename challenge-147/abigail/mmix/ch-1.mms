%
% See https://theweeklychallenge.org/blog/perl-weekly-challenge-147
%

%
% Run as: mmixal -o ch-1.mmo ch-1.mms; mmix -q ch-1.mmo
%
        LOC     Data_Segment
        GREG    @
Text    BYTE    "2 3 5 7 13 17 23 37 43 47 53 67 73 83 "
        BYTE    "97 113 137 167 173 197",10,0

        LOC     #100

Main    LDA     $255,Text
        TRAP    0,Fputs,StdOut
        TRAP    0,Halt,0