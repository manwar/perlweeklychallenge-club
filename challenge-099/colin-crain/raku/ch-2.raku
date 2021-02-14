#!/usr/bin/env perl6
#
#
#       diffraction_grating.raku
#
#         TASK #2 › Unique Subsequence
#         Submitted by: Mohammad S Anwar
#         You are given two strings $S and $T.
# 
#         Write a script to find out count of different unique subsequences
#         matching $T without changing the position of characters.
# 
#         UPDATE: 2021-02-08 09:00AM (UK TIME) suggested by Jonas Berlin,
#         missing entry [5].
#         
#         Example 1:
#             Input: $S = "littleit', $T = 'lit'
#             Output: 5
# 
#                 1: [lit] tleit
#                 2: [li] t [t] leit
#                 3: [li] ttlei [t]
#                 4: litt [l] e [it]
#                 5: [l] ittle [it]
#                 
#         Example 2:
#             Input: $S = "london', $T = 'lon'
#             Output: 3
# 
#                 1: [lon] don
#                 2: [lo] ndo [n]
#                 3: [l] ond [on]
# 
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN () ;

use Test;

plan 6;

is descend( 'london', 'lon'), 3, 'ex-2';
is descend( 'littleit', 'lit'), 5, 'ex-1';
is descend( 'abcabc', 'abc'), 4, 'abcs';
is descend( 'aabbaa', 'aba'), 8, 'repeated letters';
is descend( 'aaaa', 'aa'), 6, 'only one letter';
is descend( 'bookkeeping', 'boke'), 8, 'bookkeeping';

sub descend (Str $str, Str $target) {
    my $count = 0;
    return 0 unless all($str.chars, $target.chars) > 0;
    
    my $t   = $target.substr(0,1);
    my $idx = $str.index($t);
    
    if $idx.defined {
        $count++ if $target.chars == 1;
        $count += descend( $str.substr($idx+1), $target);
        $count += descend( $str.substr($idx+1), $target.substr(1) );    
    }

    return $count;
}















# sub descend ($str, $target) {  
#         my $count = 0;
#         return 0 unless length $str > 0 and length $target > 0;
#     
#         my $t   = substr( $target, 0, 1 );
#         my $idx = index $str, $t;
#         
#         if ($idx > -1) {
#             $count++ if length $target == 1;
#             $count += descend( substr($str, $idx+1), $target);
#             $count += descend( substr($str, $idx+1), substr( $target, 1 ));
#         }
#         
#         return $count;
# }
# 
# 
# 
# use Test::More;
# 
# is descend( 'london', 'lon'), 3, 'ex-2';
# is descend( 'littleit', 'lit'), 5, 'ex-1';
# is descend( 'abcabc', 'abc'), 4, 'abcs';
# is descend( 'aabbaa', 'aba'), 8, 'repeated letters';
# is descend( 'aaaa', 'aa'), 6, 'only one letter';
# is descend( 'bookkeeping', 'boke'), 8, 'bookkeeping';
