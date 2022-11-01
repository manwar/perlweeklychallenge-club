#!/usr/bin/env raku
use Test;

is greater-character(<e m u g>, 'b'), 'e'; 
is greater-character(<d c e f>, 'a'), 'c';
is greater-character(<s r q p>, 'm'), 'p';
is greater-character(<x j h u>, 'd'), 'h';
is greater-character(<o p n m>, 'l'), 'm';

sub greater-character($list, $target)
{
    $list.unique.grep(* gt $target).sort.head
}
