#!/usr/bin/env raku
use Test;

is broken-keyboard("Hello World", [< d >] ),           1;
is broken-keyboard("apple banana cherry", [< a e >]),  0;
is broken-keyboard("Coding is fun", Empty),            3; 
is broken-keyboard("The Weekly Challenge", [< a b >]), 2; 
is broken-keyboard("Perl and Python", [< p >]),        1;

sub broken-keyboard($str, @keys)
{
    $str.words.grep({ none /:i @keys/ }).elems
}
