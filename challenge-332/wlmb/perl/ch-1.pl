#!/usr/bin/env perl
# Perl weekly challenge 332
# Task 1:  Binary Date
#
# See https://wlmb.github.io/2025/07/26/PWC332/#task-1-binary-date
use v5.36;
use feature 'try';
die <<~"FIN" unless @ARGV;
    Usage: $0 D1 D2...
    to map the ISO dates Dn in the format YYYY-MM-DD to binary.
    FIN
my @days=(0,31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
for(@ARGV){
    try {
	die "Invalid format: $_"  unless /^(\d{4})-(\d{2})-(\d{2})$/;
	my ($year, $month, $day)=($1, $2, $3);
	die "Invalid month: $_" unless 1<=$month<=12;
	die "Invalid day: $_" unless 1<=$day<=$days[$month];
	die "Invalid day: $_" if $month==2 && $day==29 && !leap($year);
	say "$_ -> ", join "-", map {sprintf "%b", $_} ($year, $month, $day);
    }
    catch($e){
	say $e;
    }
}
sub leap($year){
    return $year%400==0 || $year%4==0 && $year%100 != 0;
}
