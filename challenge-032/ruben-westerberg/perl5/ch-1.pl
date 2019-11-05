#!/usr/bin/env perl
use strict;
use warnings;
use Getopt::Std;
use List::Util;
my %options=();
getopts("v", \%options);

my %data;

while (<>) {
	chomp;
	$data{$_}++;
}

histogram(\%data,$options{v},0);
histogram(\%data,$options{v},1);

sub histogram {
	my $h=shift;
	my $valueSort=shift;
	my $chart=shift;
	my @keys= sort keys %$h;# { length $b > length $a} keys %$h;
	my $maxKeyLength=List::Util::max map { length $_} keys %$h;
	print "\n";
	if ($valueSort) {
		@keys=sort { $$h{$b} > $$h{$a} } keys %$h;		
	}
	for (@keys) {
		my $v=$$h{$_};
		$v= "#" x $$h{$_} if $chart;
		printf("%".$maxKeyLength."s| %s\n", $_, $v);
	}
}
