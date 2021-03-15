#! /opt/local/bin/perl
#
#       wildcard_wonderland.pl
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
#         method:
#             Seeing as we already have a better-than-good pattern match engine
#             available to us in the Perl language, it seems like tha path of
#             least resistance is to transform our toy matching language into a
#             full blown regular expression and see it matches.
#             
#             It appears that the wildcard characters in our given language
#             differ slightly from their more familiar counterparts, in that
#             they match a positive number of characters only, disallowing the
#             absence of a match. That is to say, a asterisk mark matches any
#             *sequence* of characters, meaning one of more, rather than any
#             number including 0. Hinging on the common defintion of the word
#             'any', the idea of 'none' is not included and exists in
#             opposition. Hence 'none' < 'any' < 'all'.
# 
#             In any case that's what we're going to go with today.
# 
#             To this end we only need to substitute one set of character
#             classes and modifiers for the other, and, as we are asked to
#             validate the entire string, anchor the ends of our expression to
#             front and back to the input.
# 
#             To do the transmutation we'll use substitution operator, which
#             seems quite fitting.
# 
            
            
        
        
        
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";
use feature qw(say signatures);
no warnings 'experimental::signatures';


my ($str, $exp) = @_;
if (defined $str and defined $exp) {
    say validate($str, $exp);
}

sub validate ($str, $exp) {
    $exp =~ s/\?/./g;
    $exp =~ s/\*/.+/g;

    return $str =~ m/^$exp$/ ?  1
                             :  0;
}
               
            
use Test::More;

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


done_testing();
