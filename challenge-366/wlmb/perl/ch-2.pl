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
	die "Invalid time: $_" unless /^(\d|\?){2}:(\d|\?){2}/;
	say"$_ -> ",count($_);
    }
    catch($e){ warn $e; }
}

sub count($time){
    return valid($time) unless $time=~/\?/;
    my $count=0;
    for(0..9){
	$count += count($time=~s/\?/$_/r);
    }
    return $count;
}

sub valid($time){
    my ($hour, $minute) = split ":", $time;
    0<=$hour<24 && 0<=$minute<60;
}
