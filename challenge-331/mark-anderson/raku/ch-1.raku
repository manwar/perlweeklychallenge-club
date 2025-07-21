#!/usr/bin/env raku
use Test;

is last-word("The Weekly Challenge"), 9;
is last-word("   Hello   World    "), 5;
is last-word("Let's begin the fun"),  3;

sub last-word($str)
{
    $str.words.tail.chars    
}
