%
% See https://theweeklychallenge.org/blog/perl-weekly-challenge-153
%

%
% Run as: mmixal -o ch-1.mmo ch-1.mms; mmix -q ch-1.mmo
%
        LOC     Data_Segment
        GREG    @
Text    BYTE    "1 2 4 10 34 154 874 5914 46234 409114",10,0

        LOC     #100

Main    LDA     $255,Text
        TRAP    0,Fputs,StdOut
        TRAP    0,Halt,0
