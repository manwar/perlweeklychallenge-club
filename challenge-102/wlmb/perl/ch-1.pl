#!/usr/bin/env perl
# Perl weekly challenge 102
# Task 1: Rare numbers
# Slowest, simplest version
#
# See https://wlmb.github.io/2021/03/01/PWC102/#task-2-rare-numbers
use strict;
use warnings;
use v5.12;
use POSIX qw(floor);
foreach my $N(@ARGV){
    foreach my $x(10**($N-1)..10**$N-1){
        # next if $x%10==0; #uncomment to disallow reversed numbers starting in 0
	my $y=join '', reverse split '', $x;
	next if $x<=$y; #use < to allow palindromes
	my $s=$x+$y;
	next unless $s==floor(sqrt($s))**2; # test squareness of sum
	my $d=$x-$y;
	next unless $d==floor(sqrt($d))**2; # test squareness of diff
	say "N=$N\tx=$x\ty=$y\tx+y=$s=", sqrt($s),"**2\tx-y=$d=",sqrt($d),"**2";
    }
}
