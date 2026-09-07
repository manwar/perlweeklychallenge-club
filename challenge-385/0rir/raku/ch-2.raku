#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
385-Task 2: Outermost Parentheses   Submitted by: Mohammad Sajid Anwar

You are given a valid parentheses string.
Write a script to return the string after removing the outermost
parentheses of every primitive string in the primitive decomposition
of the given string.
=end comment

my @Test =
    # in                    exp
    "()()()",                 "",
    "(((())))",               "((()))",
    "(()())(())",             "()()()",
    "()((()))()",             "(())",
    "(()(()))(()())",         "()(())()()",

    "(()(())()(()()))",       "()(())()(()())",        
    "(())(((()((()())))))",   "()((()((()()))))",
    "(())(()((()((()())))))", "()()((()((()()))))",
;

plan @Test ÷ 2;

sub task(Str $a is copy -->Str) {
    my $val = 0;
    my @head-tail;
    my $head;
    for ^$a.chars -> \i {
        if $a.substr( i, 1) eq  '(' {
            ++$val;   
            $head = i if $val == 1;
        }else{
            --$val;
            @head-tail.unshift: [ $head, i] if $val == 0;
        }
    }
    for @head-tail -> ($h, $t) {
        $a.substr-rw(  $t,1) = '';
        $a.substr-rw(  $h,1) = '';
    }
    $a;
}

for @Test -> $in, $exp {
   is task( $in), $exp, "{$exp // $exp.^name()} <- $in.raku()";
}
done-testing;

my $str = "()((())())(((())))()((()))";
say qq{\nInput: \$str = "$str"\nOutput: "&task( $str)"}
