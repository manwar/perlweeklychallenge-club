#!/usr/bin/env perl6
# 
#
#       finders_keepers.raku
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
# # # # # 
# 
#         method:
#             the list is iterated through one character at a time
#             each char when evaluated replaces the fnr unless that char is not unique,
#                 the prev fnr goes on the stack
#             if the new char matches the fnr:
#                 the stack is rechecked for uniqueness
#                 the top element is popped of the stack:
#                     if the stack is empty the fnr is undef
#             the output is either the fnr or '#' if not defined
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN (Str $str = 'xyzzyxwvuvu');

## because of dynamic conditions, we need to 
## recheck uniqueness as individual chars are added 
## we will use a hash to keep track of char counts
my %unique;
my $fnr;
my @prev;
my $output;

## 1. divide str
## 2. apply function over characters to determine fnr
## 3. write either fnr or '#' to output if Nil
## 4. join back into single string
$output = $str.comb
              .map({ %unique{$_}++;  
                     $fnr = do {
                          when %unique{$_} == 1 {
                              @prev.push($fnr) if $fnr.defined;
                              $_;                       
                          }
                          when $_ === $fnr {
                              ## recheck for uniqueness
                              @prev .= grep({ %unique{$_} == 1 });
                              @prev.pop // Nil;
                          }
                          $fnr;  
                     }
                     (defined $fnr) ?? $fnr !! '#';              
                })
              .join('');

$str   .say;
$output.say;


