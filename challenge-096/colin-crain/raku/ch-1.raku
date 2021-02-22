#!/usr/bin/env perl6
#
#
#       backwards_sentence.raku
#
#        TASK #1 › Reverse Words
#         Submitted by: Mohammad S Anwar
#         
#             You are given a string $S.
# 
#             Write a script to reverse the order of words in the given string.
#             The string may contain leading/trailing spaces. The string may have
#             more than one space between words in the string. Print the result
#             without leading/trailing spaces and there should be only one space
#             between words.
# 
#             Example 1:            
#                 Input: $S = "The Weekly Challenge"
#                 Output: "Challenge Weekly The"
#  
#             Example 2:          
#                 Input: $S = "    Perl and   Raku are  part of the same family  "
#                 Output: "family same the of part are Raku and Perl"

#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN (Str $str = "         The Weekly       Challenge    ") ;

($str ~~ m:g/ (\S+) /).reverse
                      .join(' ')
                      .say;

