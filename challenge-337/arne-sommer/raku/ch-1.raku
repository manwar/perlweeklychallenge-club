#! /usr/bin/env raku

unit sub MAIN (*@num1 where @num1.elems > 0 && all(@num1) ~~ Numeric);

say @num1.map({ @num1.grep( * <= $_ ).elems -1 });

