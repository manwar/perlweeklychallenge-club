#!/usr/bin/env raku
use Test;

is longest-parenthesis('(()())'),         6;
is longest-parenthesis(')()())'),         4;
is longest-parenthesis('(((()))()(((()'), 8;
is longest-parenthesis('))))((()('),      2;
is longest-parenthesis('()(()'),          2;

# I think I want to use the <~~> recursive feature here but I 
# don't really understand it. The following comes close but it
# doesn't quite give the output I want.
         
# $str ~~ m:g/ '(' [ <-[()]>* <~~> <-[()]>* ]* ')' /;

sub longest-parenthesis($str)
{
    my  @m = $str ~~ m:g/ [ ('('+) (')'+) ]+ <?{ ~$0.chars == ~$1.chars }> /;
    max @m>>.chars
}
