#!/usr/bin/env perl
use feature 'say';
my $time = $ARGV[0] || '?5:00';
my @A = split ':', $time;
my @hh = split '', $A[0];
my @mm = split '', $A[1];
my $ans;
if ($hh[0] eq '?') {
    if ($hh[1] < 4) {
	$ans = 2;
    }
    else {
	$ans = 1;
    }
} elsif ($hh[1] eq '?') {
    if ($hh[0] eq '2') {
	$ans = 3;
    } else {
	$ans = 9;
    }
} elsif ($mm[0] eq '?') {
    $ans = 5;
} else {
    $ans = 9;
}
say "Input: ".$time;
say "Output: ".$ans;
