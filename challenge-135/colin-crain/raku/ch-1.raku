#!/usr/bin/env perl6
#
#
#       135-1-middling-thruppence.raku
#
#       Middle 3-digits
#         Submitted by: Mohammad S Anwar
#         You are given an integer.
# 
#         Write a script find out the middle 3-digits of the given integer,
#         if possible otherwise throw sensible error.
# 
#         Example 1
#             Input: $n = 1234567
#             Output: 345
#     
#         Example 2
#             Input: $n = -123
#             Output: 123
#     
#         Example 3
#             Input: $n = 1
#             Output: too short
#     
#         Example 4
#             Input: $n = 10
#             Output: even number of digits
# 
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use Test;

is mid3( 1234567 ), 345,                        'ex-1';
is mid3( -123 ),    123,                        'ex-2';
is mid3( 1 ),       "input too short",          'ex-3';
is mid3( 1000 ),    "even number of digits",    'ex-4';


sub mid3 ( $num is copy ) {

    $num .= abs;
    
    given $num.chars {
        when    $_ < 3      { return "input too short" }
        when    $_ %% 2     { return "even number of digits" }
    }
    
    $num.substr: ($num.chars/2).floor-1, 3
}


