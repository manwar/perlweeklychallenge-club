sub is-stepping( UInt $n ) {
	not so $n.comb.rotor( 2 => -1 ).first: -> ($a, $b) { abs($a - $b) != 1 }
}

sub MAIN (UInt $start = 100, UInt $end = 999) {
    .say for ($start..$end).grep( &is-stepping );
}