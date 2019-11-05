#!/usr/bin/env perl
use strict;
use warnings;

my $limit=$ARGV[0]//11;
my $maxWidth=1+length $limit**2;
printRow("",[1..$limit],$maxWidth);
print "-" x (($limit+2)*$maxWidth),"\n";
for (1..$limit) {
	my $i=$_;
	my @row;
	my $header=$_;
	for (1..$limit) {
		if ($_ >= $i) {
			push @row, $i * $_;
		}
		else {
			push @row, "";
		}
	}
	printRow( $header,\@row, $maxWidth);
}

sub printRow {
	my ($header,$data,$minWidth)=@_;
	my $output="";
        for (@$data) {
                $output.=sprintf "%".$minWidth."s",$_;
        }
	printf "%".$maxWidth."s|%s\n",$header,$output;
}

