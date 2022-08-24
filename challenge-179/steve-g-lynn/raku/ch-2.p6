#!/usr/bin/env perl6

use Stats;

my @data=(1,2,3,4,5,4,3,2,1);

&sparkline(@data);
#▁▂▂▂▃▂▂▂▁

sub sparkline (@data) {
	my $median=median @data;
	my $stddev=sd @data;
	
	for (@data) -> $data {
		if ( ($data >= ($median-$stddev)) && 
		($data <= ($median+$stddev)) ) {
			print '▂';
		}
		elsif ( $data < ($median-$stddev) ) {
			print '▁';
		}
		elsif ( $data > ($median+$stddev) ) {
			print '▃';
		}
		else {
			die "Something wrong.\n";
		}
	}
	print "\n";
	return;
}


