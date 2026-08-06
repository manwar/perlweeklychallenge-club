#!/usr/bin/env raku
use Test;

is outermost-parentheses("()()()"),         Empty.Str;
is outermost-parentheses("(((())))"),       "((()))";
is outermost-parentheses("(()())(())"),     "()()()";
is outermost-parentheses("()((()))()"),     "(())";
is outermost-parentheses("(()(()))(()())"), "()(())()()";

#
# do-over after seeing the solution from Athanasius
#

sub outermost-parentheses($str)
{
    ($str ~~ m:g/'(' <~~>* ')'/)>>.substr(1,*-1).join
}
