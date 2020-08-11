#!/usr/bin/env perl
use strict;
use warnings;

use feature ":all";
no warnings "experimental";


my $tree={
	v=>1,
	l=>{
		v=>2,
		l=>{
			v=>4
		},
		r=>{
			v=>5
		}
	},
	r=>{
		v=>3,
		l=>{
			v=>6
		},
		r=>{
			v=>7
		}
	}
};


my @stack=($tree);

while (@stack) {
	given (shift @stack) {
		my @keys=keys %$_;
		if ( "l" ~~ @keys and "r" ~~ @keys) {
			my $t=$_->{l};
			$_->{l}=$_->{r};
			$_->{r}=$t;
			push @stack, $_->{l};
			push @stack, $_->{r};
		}
	}
}

