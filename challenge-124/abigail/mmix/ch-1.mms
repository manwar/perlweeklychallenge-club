%
% See ../README.md
%

%
% Run as: mmixal -o ch-1.mmo ch-1.mms; mmix -q ch-1.mmo
%
        LOC     Data_Segment
        GREG    @
Text01  BYTE    "    ^^^^^",10,0
Text02  BYTE    "   ^     ^",10,0
Text03  BYTE    "  ^       ^",10,0
Text04  BYTE    " ^         ^",10,0
Text05  BYTE    " ^         ^",10,0
Text06  BYTE    " ^         ^",10,0
Text07  BYTE    " ^         ^",10,0
Text08  BYTE    " ^         ^",10,0
Text09  BYTE    "  ^       ^",10,0
Text10  BYTE    "   ^     ^",10,0
Text11  BYTE    "    ^^^^^",10,0
Text12  BYTE    "      ^",10,0
Text13  BYTE    "      ^",10,0
Text14  BYTE    "      ^",10,0
Text15  BYTE    "    ^^^^^",10,0
Text16  BYTE    "      ^",10,0
Text17  BYTE    "      ^",10,0

        LOC     #100

Main    LDA     $255,Text01
        TRAP    0,Fputs,StdOut
        LDA     $255,Text02
        TRAP    0,Fputs,StdOut
        LDA     $255,Text03
        TRAP    0,Fputs,StdOut
        LDA     $255,Text04
        TRAP    0,Fputs,StdOut
        LDA     $255,Text05
        TRAP    0,Fputs,StdOut
        LDA     $255,Text06
        TRAP    0,Fputs,StdOut
        LDA     $255,Text07
        TRAP    0,Fputs,StdOut
        LDA     $255,Text08
        TRAP    0,Fputs,StdOut
        LDA     $255,Text09
        TRAP    0,Fputs,StdOut
        LDA     $255,Text10
        TRAP    0,Fputs,StdOut
        LDA     $255,Text11
        TRAP    0,Fputs,StdOut
        LDA     $255,Text12
        TRAP    0,Fputs,StdOut
        LDA     $255,Text13
        TRAP    0,Fputs,StdOut
        LDA     $255,Text14
        TRAP    0,Fputs,StdOut
        LDA     $255,Text15
        TRAP    0,Fputs,StdOut
        LDA     $255,Text16
        TRAP    0,Fputs,StdOut
        LDA     $255,Text17
        TRAP    0,Fputs,StdOut
        TRAP    0,Halt,0