use strict;
use warnings;
use 5.010;

open(my $input,'<','input') or die "Can't open input: $!";

my %freq;
while(<$input>){
	chomp;
	s/\.|"|\(|\)|,|'s|--/ /g;
	while (s/\s*(\w+)\s*//) {
		$freq{$1} = 0 unless defined $freq{$1};
		$freq{$1} += 1;
	}
}

my @results;
for my $key (sort keys %freq) {
    $results[$freq{$key}] = "$freq{$key}" unless defined $results[$freq{$key}];
    $results[$freq{$key}] .= " $key";
}

defined($_) and say for @results;
