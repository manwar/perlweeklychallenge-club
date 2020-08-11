#!/usr/bin/perl
use strict;
use warnings;

# Caution: The following codes work for distinct interval heads only. 

my @L = (0) x 100;
$L[100] = 1;
$L[101] = -1;
my %interval;     # key: the head of the interval; value: the tail of the interval

sub newroute {
	for my $i ($_[0]..$_[1]) {$L[$i]++;}
	$interval{$_[0]}=$_[1];
}



newroute(2,7);
newroute(3,9);
newroute(10,12);
newroute(15,19);
newroute(18,22);

newroute(100,100); # a temporary arrangement
my @trainstation = sort {$a <=> $b} keys %interval;

my %finterval;  # key: the head of the interval; value: the tail of the interval


my $stationnum = 0;



sub seektermination {
	my $i = $_[0];
	my $nextstop = $_[1];
	while ($L[$i] > 0 and $i < $nextstop) {
		$i++;
	}

	if ($L[$i] == 0 and $i<$nextstop) {
		return $i-1;
	}
	if ($L[$i]>1) {
		$stationnum++; 
		return seektermination($_[0], $trainstation[$stationnum+1]);
	}
	if ($i==$nextstop and $L[$i-1] == 1 and $L[$i]==1) {
		return $i-1;
	}
}






while ($stationnum<=$#trainstation-1) {
	my $start = $trainstation[$stationnum];
	$finterval{$start} = seektermination($start, $trainstation[$stationnum+1]);
	$stationnum++;
}


delete $finterval{100}; #goodbye to the temporary arrangement
foreach my $s (sort {$a <=> $b} keys %finterval) {
	print "[", $s, ", ", $finterval{$s}, "]", "\n";  
}


