#!/usr/bin/env perl
# Perl weekly challenge 274
# Task 2:  Bus Route
#
# See https://wlmb.github.io/2024/06/17/PWC274/#task-2-bus-route
use v5.36;
use PDL;
die <<~"FIN" unless @ARGV;
    Usage: $0 S1 S2...
    to find when it is best to wait for the next bus,
    where S1, S2... are schedules of the form
    "[T1 T2...]" and T1, T2... are timetables of the form
    [F I D] with F the first run of each hour, I the interval
    between runs and D the duration of each run.
    FIN
for(@ARGV){
    my @schedule;
    for(pdl($_)->dog){
	my ($interval, $start, $duration)=$_->list;
	die "Interval not submultiple of 60; $interval" if 60%$interval;
	push @schedule, map {[$start+$interval*$_, $duration,0]}(0..60/$interval-1);
    }
    my @sorted=sort{$a->[0]<=>$b->[0] || $a->[1]<=>$b->[1]}@schedule;
    my $changed=1;
    while($changed){
	$changed=0;
	for(reverse 0..@sorted-1){
	    my @current=$sorted[$_]->@*;
	    my @next=$sorted[($_+1)%@sorted]->@*;
	    my $wait=($next[0]-$current[0])%60+$next[1];
	    next unless $wait<$current[1];
	    ++$changed;
	    $sorted[$_]=[$current[0], $wait, 1];
	}
    }
    my @out;
    for(0..@sorted-1){
	my @current=$sorted[$_]->@*;
	my @next=$sorted[($_+1)%@sorted]->@*;
	next unless $next[2];
	my $first=$current[0];
	my $last=$next[0];
	$last+=60 if $last<$first;
	push @out, map{$_%60} $first+1..$last;
    }
    say "$_ -> ", pdl(@out);
}
