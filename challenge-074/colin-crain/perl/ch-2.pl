#! /opt/local/bin/perl
#
#       finders_keepers.pl
#
#       TASK #2 › FNR Character
#         Submitted by: Mohammad S Anwar
#         You are given a string $S.
# 
#         Write a script to print the series of first
#         non-repeating character for the given string. Print #
#         if none found.
# 
#         Example 1
#         Input: $S = ‘ababc’
#         Output: ‘abb#c’
#             Pass 1: “a”, the FNR character is ‘a’
#             Pass 2: “ab”, the FNR character is ‘b’
#             Pass 3: “aba”, the FNR character is ‘b’
#             Pass 4: “abab”, no FNR found, hence ‘#’
#             Pass 5: “ababc” the FNR character is ‘c’
# 
#         Example 2
#         Input: $S = ‘xyzzyx’
#         Output: ‘xyzyx#’
#             Pass 1: “x”, the FNR character is “x”
#             Pass 2: “xy”, the FNR character is “y”
#             Pass 3: “xyz”, the FNR character is “z”
#             Pass 4: “xyzz”, the FNR character is “y”
#             Pass 5: “xyzzy”, the FNR character is “x”
#             Pass 6: “xyzzyx”, no FNR found, hence ‘#’
# 
#       method:
#             Again with the misdirecting name, wouldn't this be the "last"
#             non-repeating character? "first non-repeating character looking
#             backwards from a given point in a string". Bit wordy, that one.
#             But we're compiling a string of these, so "first non-repeating
#             character looking backwards from each character in a string". In a
#             sense, though, I like that figuring out what the task is becomes
#             part of the puzzle. In this sense the challenges mimic the real
#             world. 
#             
#             In any case the first order of business is to plot out the action. 
# 
#             I believe the only thing that makes sense is for '#' to be an
#             excluded character from the input, but didn't do that.
#             
#             the list is iterated through one character at a time
#             each char when evaluated replaces the fnr unless that char is not unique,
#                 the prev fnr goes on the stack, unless it is '#'
#             if the new char matches the fnr:
#                 the stack is rechecked for uniqueness
#                 the top element is popped of the stack:
#                     if the stack is empty the fnr is '#'
#             ---
#             pseudo-perl:
# 
#             list -> char:
#                 uniq{char}++
#             if uniq{char} == 1: 
#                 push stack, fnr unless fnr == '#'
#                 fnr = char
#                 next
#             if uniq{fnr} == 2:      ## match to fnr
#                 stack = grep { uniq == 1 } stack
#                 if stack has elements:
#                     fnr = pop stack
#                 else 
#                     fnr = '#'
#                 
# 
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:

my $str = shift @ARGV // '#yzzy#w';
my %uniq;
my $fnr = undef;
my @prev;
my $output;

while (my $char = substr $str, 0, 1, '') {
    $uniq{$char}++;
    
    if ($uniq{$char} == 1) {
        push @prev, $fnr unless not defined $fnr;
        $fnr = $char;
    }    
    elsif ($uniq{$fnr} == 2) {
        @prev = grep { $uniq{$_} == 1 } @prev;
        $fnr = @prev ? pop @prev : undef;
    }
    $output .= $fnr // '#';
}

say $output;
