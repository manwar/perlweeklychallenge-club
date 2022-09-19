#!/usr/bin/env -S perl -CSDA

use utf8;
use Statistics::Lite qw(median stddev);

my @data=(1,2,3,4,5,4,3,2,1);

&sparkline(@data);
#▁▂▂▂▃▂▂▂▁

sub sparkline {
	my @data = @_;
	my $median=median(@data);
	my $stddev=stddev(@data);
	
	for my $data (@data) {
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


