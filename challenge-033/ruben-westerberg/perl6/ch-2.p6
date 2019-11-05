#!/usr/bin/env perl6

my $limit=11//@*ARGS[0];
my $maxWidth=1+(chars $limit**2);
printRow "", (1..$limit), $maxWidth;
put "-" x (($limit+2)*$maxWidth);
for 1..$limit {
	my $i=$_;
	my @row;
	my $header=$_;
	for 1..$limit {
		if $_ >= $i {
			push @row, $i*$_;
		}
		else {
			push @row, "";
		}
	}
	printRow($header,@row,$maxWidth);
}

sub printRow($header, $data, $minWidth) {
	my $output="";
	for @$data {
		$output ~= sprintf "%"~$minWidth~"s",$_;
	}
	printf "%"~$minWidth~"s|%s\n",$header,$output;
}

