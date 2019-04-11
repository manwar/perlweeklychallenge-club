#!/usr/bin/env perl
use warnings;

my $lines=$ARGV[0];
die "Rows must be 3 or greater." unless ($lines >= 3);
my $current=[1];
foreach  (1 .. $lines)  {
	printRow($current); #print the current row
	$current= makeRow($current) #make the next row;
}

sub printRow {
	$in=shift;
	foreach (@$in) {
		#TODO: Add centralised format
		printf "%d ", $_;;
	}
	print "\n";
}
sub makeRow {
	my $in=shift;
	my @row=(@$in,0);
	my @outRow;
	my $previous=0;
	foreach (@row) {
		push @outRow, $_+ $previous;
		$previous=$_;
	}
	return \@outRow;
}
