#!/usr/bin/env raku
use Test;

is outermost-parentheses("()()()"),         Empty.Str;
is outermost-parentheses("(((())))"),       "((()))";
is outermost-parentheses("(()())(())"),     "()()()";
is outermost-parentheses("()((()))()"),     "(())";
is outermost-parentheses("(()(()))(()())"), "()(())()()";

sub outermost-parentheses($str)
{
    ($str ~~ m:g/(.+?) <?{ .<(> == .<)> given $0.comb.Bag }>/)>>.substr(1, *-1).join
}

sub outermost-parentheses-v2($str)
{
    my @p = $str.comb;

    .join given gather while @p
    {
         my $left  = 0;
         my $right = 0;
     
         take .[1..*-2].join given gather repeat until $right == $left
         {
             given @p.shift -> $p
             {
                 take $p;
                 $p eq '(' ?? $left++ !! $right++
             }
         }
    }
}
