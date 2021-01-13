#!/usr/bin/env perl6
use v6;

multi sub awkdiv(Int $n, 0) {   
    "You're dividing by zero!"
}

multi sub awkdiv(0, Int $d) {   
    0
}

multi sub awkdiv(Int $n, Int $d where {sign($_) == sign $n}) {
    given $d.abs {
	when * > $n.abs {0}
	default { 1+ awkdiv(($n-$d).abs,$d.abs)}
    }
}

multi sub awkdiv(Int $n, Int $d where {sign($_) !== sign $n}) {
    given $d.abs {
	when * > $n.abs {-1}
	default { -1+ awkdiv(($n+$d).abs,-$d.abs)}
    }
}

say awkdiv(@*ARGS[0].Int, @*ARGS[1].Int)

# run as <script> <numerator> <denominator>
