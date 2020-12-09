#!/usr/bin/env perl6
use v6;

sub p1max(@a where *.elems %% 2) {
    given @a.elems {
	when 0 { 0 }
	when 2 { @a.max }
	default { (
		     @a[0] + (@a[2..*].&p1max, @a[1..^(@a-1)].&p1max).min,
		     @a[*-1] + (@a[1..^(@a-1)].&p1max, @a[0..^(@a-2)].&p1max).min
		).max }
    }
}

sub winner(@a) {
    given @a.&p1max {
	when * > @a.sum/2 {"Player 1 wins"}
	when * < @a.sum/2 {"Player 2 wins"}
	default {"Draw"}
    }
}


my @coins=(1, 0.50, 0.01, 0.10, 0.05, 0.20, 2, 0.02);

say "Best strategy for player 1 results in winning ", @coins.&p1max;
say @coins.&winner;

# run as <script>
