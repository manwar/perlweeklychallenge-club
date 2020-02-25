#!/usr/env perl
# Perl Challenge 39 Task 1
# hotel lights.  Code detects non-contiguous stays
# and also allows for out-of-sequence data entry
# The data has been modified to test these

use strict;use warnings;

#initialise the intervals and time sums
my @intervals=();my $ptr=0; my $totalOn=0;    

#read data from the log file provided in the challenge
while (my $line = <DATA>) {
    my @inout=($line =~/\d\d\:\d\d/g);          # each log line has two
    push @intervals, \@inout if (@inout == 2);  # time elements
}		

# sort the data by IN times...not needed for the data provided,
# but simplifies handling of out-of-sequence data in logs
@intervals=sort {$$a[0] cmp $$b[0]} @intervals;

#merge intervals which overlap or envelop each other
while ($ptr<$#intervals){
	my @ret=mergeOverlaps($intervals[$ptr],$intervals[$ptr+1]);
	splice @intervals, $ptr,2,@ret;
	$ptr++ if (@ret>1);
}

# All remaining intervals represent contiguous on periods
foreach (@intervals){
	my $onPeriod=time2minutes($$_[1])-time2minutes($$_[0]);
	print "Lights on between ".$$_[0]." and ".$$_[1]." (for $onPeriod minutes)\n";
	$totalOn+=$onPeriod
}

#print the results
print "Total lights on period $totalOn minutes\n";

# detect and merge overlaps in two time intervals
sub mergeOverlaps{                
	my ($a,$b)=@_;          # in two sorted time intervals, overlap means 
	if ($$a[1] gt $$b[0]){  # one ends after the latter starts
		return [$$a[0],($$b[1] gt $$a[1])?$$b[1]:$$a[1]];
	}
	return $a,$b;           # no overlap, so time intervals stay
}

#convert the time string into minutes
sub time2minutes{
	my $str=shift;
	my ($hours,$minutes)=split (/:/,$str);
	return $hours*60+$minutes;
}		
	
__DATA__
1) Alex    IN: 09:10 OUT: 09:45
2) Arnold  IN: 09:15 OUT: 09:33
3) Bob     IN: 09:22 OUT: 09:55
4) Charlie IN: 09:25 OUT: 10:05
5) Steve   IN: 09:33 OUT: 10:01
6) Roger   IN: 09:44 OUT: 10:12
7) David   IN: 09:57 OUT: 10:23
8) Neil    IN: 10:01 OUT: 10:19
9) Chris   IN: 10:10 OUT: 11:00
# extra confounding data
# with non-contiguous and 
# out-of-sequence data
10)Lauren  IN: 15:00 OUT: 15:30
11)MoSalah IN: 14:50 OUT: 15:10
