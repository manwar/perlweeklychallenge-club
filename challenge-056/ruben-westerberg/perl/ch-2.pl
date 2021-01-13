#!/usr/bin/env perl
use strict;
use warnings;

use feature ":all";
no warnings "experimental";


my $tree={
	v=>5,
	l=>{
		v=>4, 
		l=>{
			v=>11,
			l=>{
				v=>7
			},
			r=>{
				v=>2
			}
		},
	},
	r=>{
		v=>8,
		l=>{
			v=>13,
		},
		r=>{
			v=>9,
			r=>{
				v=>1
			}
		}
	}
};

my $target=$ARGV[0]//22;

my @stack=($tree);

while (@stack) {
	given (shift @stack) {
		for my $k (qw<l r>) {
			if (exists $_->{$k}) {
				$_->{$k}{p}=$_;
				push @stack, $_->{$k};
			}
		}

		if ((! exists $_->{l}) and (! exists $_->{r})) {
			my $p=$_;
			my @path;
			my $sum=0;
			while (defined $p) {
				push @path, $p->{v};
				$sum+=$p->{v};
				$p=$p->{p};

			}
			if ($sum==$target) {
				say join "->", reverse @path;

			}
		}

	}
}
