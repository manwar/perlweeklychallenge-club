#! /opt/local/bin/perl
#
#       ab_interneg.pl
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
#             METHOD:
#                 This is a really interesting problem. At first look it has
#                 presents a very complex solution space, but because all of the
#                 strings maintain their ordering throughout the actual decision
#                 making never gets beyond binary choices. The key to cracking
#                 it is to entertain a complete idea of what "interleaving" is.
# 
#                 Interleaving is the process of taking two strings and, from
#                 the beginnings of both, selecting and gathering partitions of
#                 first one string and then the other, assembling a constructed
#                 third string from the two until all characters from both
#                 inputs are utilized.
# 
#                 Ok, but what does that mean to us?
# 
#                 If we start with the two strings, we are given the choice to
#                 take the first letter from either string to begin our common
#                 concatenation. After that character is added, we are given the
#                 choice of continuing to add the next letter from our string or
#                 switch and add the first letter from the other string. When a
#                 letter is selected, the position to be added next from that
#                 string is advanced; if one string becomes exhausted, the
#                 assembly continues with the last part of the remaining string.
#                 The process continues until there are no more options for
#                 characters to be added.
# 
#                 Practically, we can physically remove letters from the strings
#                 as we use them, which lightens the bookkeeping load. This
#                 includes the target string we're validating; when a character
#                 is chosen that letter is removed from the remaining string
#                 left to match. We don't need to keep a record of the string
#                 we're assembling, because if we run out of letters between our
#                 two input strings and the target simultaniously we've matched
#                 our last letter. The interleaving is has been successful, and
#                 we already know what the result looks like. 
#                
                
#       
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";
no warnings 'recursion';

## ## ## ## ## MAIN:

my $VERBOSE = 1;

my ($A, $B, $C) = @_;

## let's not bother with command line input this time, shall we?
$A = "AXXZ";
$B = "XXYZ";
$C = "AXXYXZXZ";
say 0 and exit if length($A)+length($B)!=length($C);

say interleave($A, $B, $C);

## ## ## ## ## SUBS:

sub interleave {
    my ($A, $B, $C) = @_;
    say "A $A \nB $B \nC $C\n" if $VERBOSE;

    return 1 unless (  $A or $B or $C );          ## we've used all our letters
    
    for ($A,$B) {
        if (substr($_, 0, 1) eq substr($C, 0, 1) ) {
            my $taken   = substr $_, 1;
            my $other   = $_ eq $A ? $B : $A;
            my $target  = substr $C, 1;
            say "took ", substr($_, 0, 1), " target now $target\n" if $VERBOSE;
            return 1 if interleave($taken, $other, $target);
        }
    }
    say "backtracking..." if $VERBOSE;
    
    return 0;
}