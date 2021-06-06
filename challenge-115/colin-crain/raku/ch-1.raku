#!/usr/bin/env perl6
#
#
#       115-1-string_cheese.raku
#
#       String Chain
#         Submitted by: Mohammad S Anwar
#         You are given an array of strings.
# 
#         Write a script to find out if the given strings can be chained to form
#         a circle. Print 1 if found otherwise 0.
# 
#         A string $S can be put before another string $T in circle if the last
#         character of $S is same as first character of $T.
# 
#         Examples:
#         Input: @S = ("abc", "dea", "cd")
#         Output: 1 as we can form circle e.g. "abc", "cd", "dea".
# 
#         Input: @S = ("ade", "cbd", "fgh")
#         Output: 0 as we can't form circle.
# 
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN () ;

use Test;

plan 5;

is chain(["abc", "dea", "cd" ]), "abc cd dea",              'ex-1';
is chain(["ade", "cbd", "fgh"]), Nil,                       'ex-2';
is chain(["abc", "dea", "cda"]), Nil,                       'short loop';
is chain(["abc", "aea", "cda"]), "abc cda aea",             'multi first';
is chain(["abc", "abc", "cda", "cda"]), "abc cda abc cda",  'repeats';





sub chain (@str, *@chain) {
    @chain.unshift(@str.shift) unless @chain.elems;
    
    ## base case: if no more in pool check last loop link
    if @str == 0 {
        return @chain[*-1].substr(*-1) eq @chain[0].substr(0,1)
            ?? @chain.join(' ')
            !! Nil;
    }
    
    my @next = @str.grep({@chain[*-1].substr(*-1,1) eq $_.substr(0,1)}) ;

    ## base case: no next link and still more in pool fails
    return Nil if @next ~~ Empty and @str.elems;
    
    for @next -> $link {
        my @possible = @str;
        splice @possible, @possible.first(* eq $link, :k), 1;
        my $result = chain( @possible, |@chain, $link );
        return $result if $result.defined;
    }
    return Nil;
}
