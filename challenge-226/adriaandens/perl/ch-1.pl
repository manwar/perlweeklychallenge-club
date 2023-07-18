use strict;
use warnings;

use feature 'say';

while((my $s = <DATA>)) {
	my @indices = split /, /, <DATA>;
	say "Solution: " . x($s, \@indices);
}

sub x {
	my @og = split //, shift;
	my $indices = shift;
	my @r = (); my $i = 0;
	map { $r[$_] = $og[$i++] } @{$indices};
	return join('', @r);
}


__DATA__
lacelengh
3, 2, 0, 5, 4, 8, 6, 7, 1
rulepark
4, 7, 3, 1, 0, 5, 2, 6
