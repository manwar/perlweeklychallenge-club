#!/usr/bin/env perl6
use v6;

sub rk_perm(@a, $k) {
    given my ($ix,$fact) = ((1..@a.elems) Z [\*](1..@a.elems)).first({ $_[1] < $k }, :end) {
	when ! *.[0].defined { @a }
	when *.[0] == @a.elems { @a.reverse }
	when *.[0] < @a.elems-1 {
	    (|@a[^(@a.elems-$ix-1)], |rk_perm(@a[(@a.elems-$ix-1)..*], $k))
	}
	default {
	    my $init_ix=ceiling($k/$fact)-1;
	    my @rest=(@a.keys (-) $init_ix).keys.sort;
	    (@a[$init_ix], |rk_perm(@a[@rest], $k-($fact * (ceiling($k/$fact)-1))))
	}
    }
}

say rk_perm((1..@*ARGS[0].Int).List, (@*ARGS[1] || 1).Int);

# run as <script> <$n for which we're permuting 1..$n> <the rank $k of the permutation you want> 
