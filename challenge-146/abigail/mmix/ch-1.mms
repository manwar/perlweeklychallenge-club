%
% See ../README.md
%

%
% Run as: mmixal -o ch-1.mmo ch-1.mms; mmix -q ch-1.mmo
%
        LOC     Data_Segment
        GREG    @
Text    BYTE    "104743",10,0

        LOC     #100

Main    LDA     $255,Text
        TRAP    0,Fputs,StdOut
        TRAP    0,Halt,0