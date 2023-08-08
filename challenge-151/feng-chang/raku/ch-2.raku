#!/bin/env raku

unit sub MAIN(*@V);

put max-gain(@V);

multi max-gain()         { 0 }
multi max-gain([$a])     { $a }
multi max-gain([$a, $b]) { max($a, $b) }
multi max-gain(@V)       { max(@V[0] + max-gain(@V.tail(*-2)), max-gain(@V.tail(*-1))) }
