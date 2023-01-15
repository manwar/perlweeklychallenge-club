#! /usr/bin/env raku

unit sub MAIN (*@list where @list.elems > 0 && all(@list) ~~ /^<[0..9]>*$/);

say @list.Bag.values.map({ (^$_).sum }).sum;
