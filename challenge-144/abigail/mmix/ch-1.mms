%
% See ../README.md
%

%
% Run as: mmixal -o ch-1.mmo ch-1.mms; mmix -q ch-1.mmo
%
        LOC     Data_Segment
        GREG    @
Text    BYTE    "4, 6, 9, 10, 14, 15, 21, 22, 25, 26, 33, 34, 35, 38, "
        BYTE    "39, 46, 49, 51, 55, 57, 58, 62, 65, 69, 74, 77, 82, "
        BYTE    "85, 86, 87, 91, 93, 94, 95",10,0

        LOC     #100

Main    LDA     $255,Text
        TRAP    0,Fputs,StdOut
        TRAP    0,Halt,0