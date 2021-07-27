#!/usr/bin/env perl
use warnings;
use v5.12;

# run <script> <score>

use feature qw(signatures);
no warnings qw(experimental::signatures);

sub comp($nr,$bd) {
    my $tab=[[[],],];
    for my $n (1..$nr) {
	my $item=[];
	for my $i (1..$bd) {
	    (scalar @{$tab} >= $i) && do {
		my @suppPrev = map {my @supp = ($i, @{$_}); \@supp} @{$tab->[-$i]};
		push @{$item}, @suppPrev;
	    };
	}
	scalar @{$tab} >= $bd && do { shift @{$tab} };
	push @{$tab}, $item;
    }
    return $tab->[-1];
}

for (@{comp($ARGV[0],3)}) {
    say "@{$_}";
}

