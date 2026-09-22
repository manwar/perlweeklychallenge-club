#!/usr/bin/env perl
# Perl weekly challenge 392
# Task 1:  Convert Palindrome
#
# See https://wlmb.github.io/2026/09/20/PWC392/#task-1-convert-palindrome
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 S0 S1...
    to find the smallest palindrome that may be obtained by
    prepending letters to the string Sn
    FIN
for(@ARGV){
    say "$_ -> ",
	s/^               # start of string
          (               # start of leading palindrome $1
          (.*)            # first half of leading palindrome, maybe empty $2
          (.?)            # middle letter, if any  $3
          (??{            # start code
           "".reverse($2) # build second half of palindrome
                          # by reversing first half
          })              # end of second half
          )               # end of leading palindrome $1
          (.*)            # remaining letters $4
          $               # end of string
      /reverse($4).$1.$4  #
      /rex;               # return modified string, expressions in replacement, legible
}
