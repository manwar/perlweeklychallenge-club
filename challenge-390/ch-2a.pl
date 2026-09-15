#!/usr/bin/env perl
# Perl weekly challenge 390
# Task 2:  Order Characters
#
# See https://wlmb.github.io/2026/09/11/PWC390/#task-2-order-characters
use v5.36;
use List::Util qw(minstr);
die <<~"FIN" unless @ARGV and @ARGV%2==0;
    Usage: $0 S0 K0 S1 K1...
    to find the minimum string that can be obtained from
    string Sn by repeatedly moving one of its Kn first characters
    to the end.
    FIN
for my($string, $k)(@ARGV){
    say "$string $k -> ", order($string, $k);
}
sub order($string, $k){
    return $string if $k<=0;
    return minstr map{
	$string =~ s/^(.{$_})(.*)$/$2$1/r
    }(0..length($string) - 1) if $k==1;
    return join "", sort{$a cmp$b} split "", $string;
}
