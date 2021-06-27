%
% See ../README.md
%

%
% Run as: mmixal -o ch-2.mmo ch-2.mms; mmix -q ch-2.mmo
%
        LOC     Data_Segment
        GREG    @
Text    BYTE    "a8 c7 e6 c5 b3 c1 a2 c3 b1 a3 c4 b2",10,0

        LOC     #100

Main    LDA     $255,Text
        TRAP    0,Fputs,StdOut
        TRAP    0,Halt,0
