#! /usr/bin/env raku

subset PositiveInt of Int where * > 0;

unit sub MAIN (*@numbers where @numbers.elems > 0 && all(@numbers) ~~ PositiveInt);

say @numbers.map({ "▁▂▃▄▅▆▇█".comb.[$_ / max(@numbers) * 7] }).join;
