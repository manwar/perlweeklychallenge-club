#!/usr/bin/env perl6
my $limit=15;
my %boxes;
%boxes{<R B G Y P>}=({c=>1,w=>1,},{c=>2, w=>1},{c=>2,w=>2},{c=>4,w=>12},{c=>10,w=>4});
.value<r>=.value<c>/.value<w> for %boxes;

my @b= %boxes.keys.sort( ->$a,$b { %boxes{$b}<r> <=> %boxes{$a}<r>});

my @selected;
my $totalWeight;
my $totalCost;
while (@b) {
	state $rem=$limit;
	my $tmp=$rem - %boxes{@b[0]}<w>;
	if $tmp < 0 {
		@b.shift;
		next;
	}
	@selected.push: @b[0];
	$rem=$tmp;
}
put "Selected boxes: @selected[]";
put "Total cost: "~sum(%boxes{@selected}>>.<c>);
put "Total weight: "~sum(%boxes{@selected}>>.<w>);

