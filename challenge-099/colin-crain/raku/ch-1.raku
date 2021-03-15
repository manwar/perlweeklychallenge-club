#!/usr/bin/env perl6
#
#       wildcard_wonderland.raku
#
#         TASK #1 › Pattern Match
#         Submitted by: Mohammad S Anwar
#         You are given a string $S and a pattern $P.
# 
#         Write a script to check if given pattern validate the entire string.
#         Print 1 if pass otherwise 0.
# 
#         The patterns can also have the following characters:
# 
#         ? - Match any single character.
#         * - Match any sequence of characters.
#         
#         Example 1:
#             Input: $S = "abcde" $P = "a*e"
#             Output: 1
#             
#         Example 2:
#             Input: $S = "abcde" $P = "a*d"
#             Output: 0
#             
#         Example 3:
#             Input: $S = "abcde" $P = "?b*d"
#             Output: 0
#             
#         Example 4:
#             Input: $S = "abcde" $P = "a*c?e"
#             Output: 1
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

sub validate( Str $str, Str $exp is copy ) {
    $exp ~~ s:g/\?/./;
    $exp ~~ s:g/\*/.+/;
        
    return $str ~~ m/^<$exp>$/ ?? 1 
                               !! 0
}

multi sub MAIN ( Str $str, Str $exp ) {
    say validate( $str, $exp );
}

multi sub MAIN ( ) {

    use Test;
    plan 12;

    is validate("abcde", "a*e"),    1, 'ex-1';
    is validate("abcde", "a*d"),    0, 'ex-2';
    is validate("abcde", "?b*d"),   0, 'ex-3';
    is validate("abcde", "a*c?e"),  1, 'ex-4';

    is validate("abcde", "bc?e"),   0, 'no head';
    is validate("abcde", "ab*c?e"), 0, '* cannot be empty';
    is validate("abcde", "a*c???"), 0, '? cannot be empty';
    is validate("abcde", "a*c?"),   0, 'no tail';

    is validate("a??cde", "a*c*"),  1, '? in input';
    is validate("a***c*", "a*c?"),  1, '* in input';

    is validate("?*??*??***?*", "????????????"),   1, 'line noise';
    is validate("************", "*"),              1, 'password';

}



    

















# my ($str, $exp) = @_;
# if (defined $str and defined $exp) {
#     say validate($str, $exp);
# }
# 
# sub validate ($str, $exp) {
#     $exp =~ s/\?/./g;
#     $exp =~ s/\*/.+/g;
# 
#     return $str =~ m/^$exp$/ ?  1
#                              :  0;
# }
