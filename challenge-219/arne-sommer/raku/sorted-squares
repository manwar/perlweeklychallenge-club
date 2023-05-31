#! /usr/bin/env raku

unit sub MAIN (*@list where @list.elems >= 1 && all(@list) ~~ Int);

say '(' ~ @list.map( * ** 2 ).sort.join(", ") ~ ')';
