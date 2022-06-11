#!/usr/bin/env raku

use Prime::Factor;

say "The smallest positive square-free integers are\n\t{(1..500).grep(*.&prime-factors.Bag.values.all < 2).join(', ')}";
