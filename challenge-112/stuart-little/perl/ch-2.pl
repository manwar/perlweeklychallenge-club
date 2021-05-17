#!/usr/bin/perl
use warnings;
use v5.12;

# run <script> <number>

use feature qw(signatures);
no warnings qw(experimental::signatures);

my %memo=(
    1 => [[1,],],
    2 => [[1,1],[2,]]
);

sub memoSteps($n) {
    (! exists $memo{$n}) && do {
	my @prevTot = ((map {my @ar = (1,@{$_}); \@ar} @{memoSteps($n-1)}), (map {my @ar = (2,@{$_}); \@ar} @{memoSteps($n-2)}));
	$memo{$n} = \@prevTot;
    };
    return $memo{$n};
}

my @res = @{memoSteps($ARGV[0])};
say scalar @res, "\n", "-" x 10;

for (@res) {
    say "@{$_}";
}
