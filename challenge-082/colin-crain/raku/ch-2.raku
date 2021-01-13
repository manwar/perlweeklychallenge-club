#!/usr/bin/env perl6
# 
#
#       ab_interneg.raku
#
#         TASK #2 › Interleave String
#         Submitted by: Mohammad S Anwar
#             You are given 3 strings; $A, $B and $C.
# 
#             Write a script to check if $C is created by interleave $A and $B.
# 
#             Print 1 if check is success otherwise 0.
# 
#             Example 1:
#                 Input:
#                     $A = "XY"
#                     $B = "X"
#                     $C = "XXY"
# 
#                 Output: 1
#                     EXPLANATION
#                     "X" (from $B) + "XY" (from $A) = $C
# 
#             Example 2:
#                 Input:
#                     $A = "XXY"
#                     $B = "XXZ"
#                     $C = "XXXXZY"
# 
#                 Output: 1
#                     EXPLANATION
#                     "XX" (from $A) + "XXZ" (from $B) + "Y" (from $A) = $C
#  
#             Example 3:
#                 Input:
#                     $A = "YX"
#                     $B = "X"
#                     $C = "XXY"
# 
#                 Output: 0
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN (Str $A = "AXXZ", Str $B = "XXYZ", Str $C = "AXXYXZXZ") ;

my $VERBOSE = True;     ## visually examine progress

say 0 and exit if $A.chars + $B.chars != $C.chars;

say "\noutput: ", interleave($A, $B, $C);


## ## ## ## ## SUBS:

sub interleave (Str $A, Str $B, Str $C) {

    say "\nA $A \nB $B \nC $C" if $VERBOSE;

    return 1 unless any(  $A, $B, $C );          ## we've used all our letters
    
    for $A,$B {
        when $_.starts-with: $C.substr(0, 1) {
            my $taken   = $_.substr(1);
            my $other   = $_ eq $A ?? $B !! $A;
            my $target  = $C.substr(1);
            say "took " ~ $_.substr(0, 1) ~ " target now $target" if $VERBOSE;
            return 1 if interleave($taken, $other, $target);
        }
    }
    return 0;
}
