#!/usr/bin/env raku
use Test;

is outermost-parentheses("()()()"),         Empty.Str;
is outermost-parentheses("(((())))"),       "((()))";
is outermost-parentheses("(()())(())"),     "()()()";
is outermost-parentheses("()((()))()"),     "(())";
is outermost-parentheses("(()(()))(()())"), "()(())()()";

sub outermost-parentheses($str)
{
    ($str ~~ m:g/(.+?) <?{ .<(> == .<)> given $0.comb.Bag }>/)>>.substr(1, *-1)
                                                                .join
}

sub outermost-parentheses-v2($str)
{
    my @p = $str.comb;

    my @i = gather
    {
        while temp @p
        {
            my $left  = 0;
            my $right = 0;
 
            repeat until $right == $left
            {
                @p.shift eq '(' ?? $left++ !! $right++
            } 

            take $left + $right 
        }
    }

    [~] @p.rotor(@i)>>[1..*-2]>>.join
 }
