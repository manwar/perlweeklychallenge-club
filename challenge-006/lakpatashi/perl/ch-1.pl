#!/usr/bin/perl

use strict;
use warnings;
use feature "switch";

# PART 1
# Assuming all given no. are positives e.g 2 3 5 6
# and I'm not sorting the given input series
my ($first,$last);
my $i = 0;
for my $x (@ARGV){
	if(not defined $first){
		$first = $last = $x;
	}elsif( $last+1 < $x){
			my $res = $first==$last? "$first": "$first-$last";
			print "$res\n";
			$first = $last = $x;
	}else{
			$last = $x;
	}
	if($i == $#ARGV){
		my $res = $first==$last? "$first": "$first-$last";
		print "$res\n";
	}
	$i++;
}


