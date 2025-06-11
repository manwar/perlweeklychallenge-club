#! /usr/bin/env raku

subset BinaryDigit of Int where * eq any(0,1);

unit sub MAIN (*@binary where @binary.elems >= 1 && all(@binary) ~~ BinaryDigit,
               :v(:$verbose));

my @ones = @binary.join.split(/0+/);

say ": One strings: { @ones.join(",") }" if $verbose;

say @ones.max.chars;