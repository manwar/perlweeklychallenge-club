#!/usr/bin/env perl6
#
#
#       harmonic_string_section.raku
#
#       TASK #1 › Isomorphic Strings
#             Submitted by: Mohammad S Anwar
#             You are given two strings $A and $B.
#
#             Write a script to check if the given strings are
#             Isomorphic. Print 1 if they are otherwise 0.
#
#             Example 1:
#             Input: $A = "abc"; $B = "xyz"
#             Output: 1
#             Example 2:
#             Input: $A = "abb"; $B = "xyy"
#             Output: 1
#             Example 3:
#             Input: $A = "sum"; $B = "add"
#             Output: 0
#
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN (Str $A = 'xxy', Str $B = 'aab') ;


say 0 and exit if $A.chars != $B.chars;

my %forward;
my %invert = SetHash.new;

for 0..$A.chars {
    my $ch-A = $A.substr($_,1);
    my $ch-B = $B.substr($_,1);

    say 0 and exit if $ch-B ∈ %invert and not %forward{$ch-A}:exists;

    if %forward{$ch-A}:exists {
        say 0 and exit if %forward{$ch-A} ne $ch-B;
    }
    else {
        %forward{$ch-A} = $ch-B;
#         %invert.set($ch-B);        ## needs 2020.2 ? not sure how to use this
        %invert{$ch-B} = Nil;
    }
}

say 1;




