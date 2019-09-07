#!/usr/bin/env perl
use strict;
use warnings;
my %index;
for my $path (@ARGV) {
	open my $h, "<",$path;
	my $number=1;
	while (my $line=<$h>) {
		my @words=split /\W+/, $line;
		for my $w (@words) {
			$index{$w}{$path}{count}++;
			push @{$index{$w}{$path}{lines}}, $number;
		}
		$number++;
	}
	close $h;
}
for (sort keys %index) {
	print "Word: $_\n";
	my $e=$index{$_};
	for (sort keys %$e) {
		printf "\tFile: %s\t Count: %s\t Line: %s\n",$_,$$e{$_}{count},join " ", @{$$e{$_}{lines}};
	}
}
