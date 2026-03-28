#!/usr/bin/env perl
# Perl weekly challenge 366
# Task 2:  Valid Times
#
# See https://wlmb.github.io/2026/03/27/PWC366/#task-2-valid-times
use v5.36;
use feature qw(try);
die <<~"FIN" unless @ARGV;
    Usage: $0 T0 T1...
    to find in how many ways we may get a valid time from Tn
    by replacing question marks by digits
    FIN
for(@ARGV){
    try {
	die "Invalid time: $_" unless /^(\d|\?){2}:(\d|\?){2}$/;
	say "$_ -> ", count($_);
    }
    catch($e){ warn $e; }
}

sub count($time){
    state @htests=qw(24 \?\? 10 /[01]\?/ 4 2\? 0 [3-9]\? 2 \?[4-9] 3 \?[0-3]);
    state $hmax=24;
    state @mtests=qw(60 \?\? 10 /[0-5]\?/ 0 [6-9]\? 6 \?[0-9]);
    state $mmax=60;
    my ($hours, $minutes)=split ':', $time;
    return count_aux($hours, $hmax, @htests)*count_aux($minutes, $mmax, @mtests);
}

sub count_aux($num, $max, @tests){
    for my ($result, $re)(@tests){
	return $result if $num=~/^$re$/;
    }
    return 0 <= $num < $max;
}
