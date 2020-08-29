#!/usr/bin/perl
# Test: ./ch-1.pl
use Modern::Perl;
use List::Util qw /sum0/;
use Algorithm::Combinatorics qw(combinations_with_repetition);

my @C = (1, 2, 4);
my $S = 6;

my $total = 0;
my $solutions;

for my $size (reverse(1 .. $S)) {
	my $iter = combinations_with_repetition(\@C,$size);
	while (my $v = $iter->next) {
		if (sum0(@$v) == $S) {
			$total++;
			$solutions .= '(' . (join ',', @$v) . ')' . "\n"
		}
	}
}

say "Output: " . $total . ' solutions';
print $solutions;
