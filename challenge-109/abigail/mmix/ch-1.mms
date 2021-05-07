%
% See ../README.md
%

%
% Run as: mmixal -o ch-1.out ch-1.mms; mmix -q ch-1.out
%
        LOC     Data_Segment
        GREG    @
Text1   BYTE    "0, 0, 0, 2, 0, 5, 0, 6, 3, 7, 0, 15, 0, ",0
Text2   BYTE    "9, 8, 14, 0, 20, 0, 21",10,0

        LOC     #100
        
Main    LDA     $255,Text1
        TRAP    0,Fputs,StdOut
        LDA     $255,Text2
        TRAP    0,Fputs,StdOut
        TRAP    0,Halt,0
