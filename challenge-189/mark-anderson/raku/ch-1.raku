#!/usr/bin/env raku
use Test;

is greater-character(<e m u g>, 'b'), 'e'; 
is greater-character(<d c e f>, 'a'), 'c';
is greater-character(<s r q p>, 'm'), 'p';
is greater-character(<x j h u>, 'd'), 'h';
is greater-character(<o p n m>, 'l'), 'm';
is greater-character(<o p n m>, 'y'),  ∞ ;

sub greater-character($list, $target)
{
    # This was my original solution 🤦
    # $list.unique.grep(* gt $target).sort.head

    # After looking at solutions from Laurent, Feng, and others
    # I am shamelessly changing my answer to this.

    min $list.grep(* gt $target)
}
