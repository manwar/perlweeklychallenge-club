#!/usr/bin/env perl
# Perl weekly challenge 157
# Task 2: Brazilian number
#
# See https://wlmb.github.io/2022/03/21/PWC157/#task-2-brazilian-number
use v5.12;
use warnings;
use POSIX qw(ceil floor);
N:
    for my $n(@ARGV){
	for my $b(2..$n-2){
	    my $m=ceil(log($n)/log($b));
	    my $d=floor($n*($b-1)/($b**$m-1));
	    say("$n=", (($d)x$m)," in base $b is Brazilian"), next N
		if $d*($b**$m-1)/($b-1)==$n
	}
	say "$n is not Brazilian"
}
