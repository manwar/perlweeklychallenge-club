#!/usr/bin/env raku
use Test;

is word-count(<unicode xml raku perl>), 2;
is word-count(<the weekly challenge>),  2;
is word-count(<perl python postgres>),  0;

sub word-count(@list)
{
    # not going to consider y as a possible vowel

    @list.grep({ .starts-with(any <a e i o u>) or .ends-with(any <a e i o u>) })
         .elems
}
