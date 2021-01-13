#!/usr/bin/env perl6
use v6;

sub surv(@a where *.elems >= 1) {
    given @a.elems {
	when * <= 2 {@a[0]}
	default {
	    (|@a[2..*], @a[0]).&surv
	}
    }
}

say (1..@*ARGS[0].Int).&surv.base(2)

# run as <script> <number of players>
