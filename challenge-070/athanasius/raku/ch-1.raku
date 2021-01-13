use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 070
=========================

Task #1
-------
*Character Swapping*

*Submitted by:* Mohammad S Anwar

You are given a string $S of size $N.

You are also given swap count $C and offset $O such that $C >= 1, $O >= 1,
$C <= $O and $C + $O <= $N.

*UPDATE: 2020-07-20 16:10:00*
*Pete Houston suggested to put additional constraint i.e. $C <= $O. He presented
the use case $S = 'abcd', $C = 2, $O = 1.*

Write a script to perform character swapping like below:

 $S[ 1 % $N ] <=> $S[ (1 + $O) % $N ]
 $S[ 2 % $N ] <=> $S[ (2 + $O) % $N ]
 $S[ 3 % $N ] <=> $S[ (3 + $O) % $N ]
 ...
 ...
 $S[ $C % $N ] <=> $S[ ($C + $O) % $N ]

*Example 1*

 Input:
     $S = 'perlandraku'
     $C = 3
     $O = 4

 Character Swapping:
     swap 1: e <=> n = pnrlaedraku
     swap 2: r <=> d = pndlaerraku
     swap 3: l <=> r = pndraerlaku

 Output:
     pndraerlaku

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

my Bool constant DISPLAY-SWAP = True;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 070, Task #1: Character Swapping (Raku)\n".put;
}

#===============================================================================
sub MAIN
(
    Str:D  $S where { $S.chars > 0 },          #= Non-empty string
    UInt:D $C where { $C ≥ 1 },                #= Swap count: integer >= 1
    UInt:D $O where { $O ≥ 1 && $C ≤ $O &&     #= Offset: integer >= 1 such that
                      $C + $O ≤ $S.chars }     #= C <= O and C + O <= |S|
)
#===============================================================================
{
    "Input:\n    \$S = '$S'\n    \$C = $C\n    \$O = $O\n".put;

    'Character Swapping:'.put if DISPLAY-SWAP;

    my Str $s = $S;
           $s = swap($s, $_, $O) for 1 .. $C;
    
    ''.put                    if DISPLAY-SWAP;
    "Output:\n    $s".put;
}

#-------------------------------------------------------------------------------
sub swap(Str:D $S, UInt:D $idx, UInt:D $O --> Str:D)
#-------------------------------------------------------------------------------
{
    my UInt $N     =  $S.chars;
    my UInt $idx-l =  $idx       % $N;
    my UInt $idx-r = ($idx + $O) % $N;
    my Str  $chr-l =  $S.substr: $idx-l, 1;
    my Str  $chr-r =  $S.substr: $idx-r, 1;
    my Str  $new-s =  $S;

    $new-s.substr-rw($idx-l, 1) = $chr-r;
    $new-s.substr-rw($idx-r, 1) = $chr-l;

    "    swap: $idx: $chr-l <=> $chr-r = $new-s".put if DISPLAY-SWAP;

    return $new-s;
}

#-------------------------------------------------------------------------------
sub USAGE()
#-------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

################################################################################
