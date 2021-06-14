#!/usr/bin/env perl6
#
#
#       sequet-number.raku
#
#         Number Sequence
#         Submitted by: Mohammad S Anwar
#         You are given a number $N >= 10.
# 
#         Write a script to split the given number such that 
#         the difference between two consecutive numbers is 
#         always 1 and it shouldn’t have leading 0.
# 
#         Print the given number if it impossible to split the number.
# 
#         Example
#         
#             Input : $N = 1234
#             Output: 1,2,3,4
# 
#             Input : $N = 91011
#             Output: 9,10,11
# 
#             Input : $N = 10203
#             Output: 10203 as it is impossible to split satisfying the conditions.
#             
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN (Int $num = 10099) ;

my $out ;

for 1..($num.chars/2).ceiling -> $group { 
    if $out = match_next_segment($num, 0, $group) {
        $out.join(',').say;
        return;
    }
}
say $num;

sub match_next_segment ($num, $start = 0, $len = 1, $prev = () ) {
    my $seg = $num.substr: $start, $len;
    my $part = (|$prev, $seg);
    return $part if $num.chars == $start+$len;
    for $seg+1, $seg-1 -> $next {
        my $len2 = $next.chars;
        if $num.substr($start+$len, $len2) == $next  {
            my $sol = match_next_segment($num, $start+$len, $len2, $part);
            return $sol if $sol.defined;
        }        
    }
    return;
}
