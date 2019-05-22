#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

# Read in data to rank in from file.
# Source: http://wdi.worldbank.org/table/1.3
my %data;
open my $wdi_gini, "<", "../wdi_world_bank_gini_most_recent.tsv";
while (my $line = <$wdi_gini>) {
	chomp $line;
	my ($country, $year, $gini) = split /\t/, $line;
	$gini = -1 if $gini eq '..';
	push @{$data{$gini}}, $country;
}

my $running_count = 0;
my $dr = 1;
say "Country\tGini (World Bank)\tStandard Ranking\tModified Ranking\tDense Ranking";
for my $g (sort {$b <=> $a} keys %data) {
	my @countries = @{$data{$g}};
	$g = "NA" if $g == -1;
	for my $c (@countries) {
		say "$c\t$g\t" . ($running_count+1) . "\t" . ($running_count+@countries) . "\t" . $dr;
	}
	$running_count += @countries;
	$dr++;
}