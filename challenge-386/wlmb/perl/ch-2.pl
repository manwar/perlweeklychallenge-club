#!/usr/bin/env perl
# Perl weekly challenge 386
# Task 2:  Rational Numbers
#
# See https://wlmb.github.io/2026/08/10/PWC386/#task-2-rational-numbers
use v5.36;
use feature qw(try);
sub to_num_den(@x){
    map {
	die "Not a rational: $_" unless /^(\d*).(\d*)(\((\d+)\))?$/;
	my ($int, $frac, $rec) = map {$_||0} ($1, $2, $4);
	my ($n, $m) = map {length} $2, $4;
	[
	 (10**$m-1)*(10**$n*$int+$frac)+$rec,
	  10**$n*(10**$m-1)
	]
    } @x
}

for my($r1,$r2)(@ARGV){
    try {
	my ($nd1, $nd2) = to_num_den($r1, $r2);
	say $r1,
	    $nd1->[0]*$nd2->[1]==$nd1->[1]*$nd2->[0]?" == ":" != ",
	    $r2;
    }
    catch($e){warn $e;}
}
