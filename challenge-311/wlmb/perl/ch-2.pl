#!/usr/bin/env perl
# Perl weekly challenge 311
# Task 2:  Group Digit Sum
#
# See https://wlmb.github.io/2025/03/03/PWC311/#task-2-group-digit-sum
use v5.36;
use List::Util qw(sum0);
die <<~"FIN" unless @ARGV && @ARGV%2==0;
    Usage: $0 L0 N0 L1 N1...
    to recursively sum the digits of groups of digits of length Ln
    taken from the numbers Nn until a fixed point is found.
    FIN
for my($length, $string)(@ARGV){
    warn("Only digits allowed in string: $string"), next unless $string=~/^\d+$/;
    my $new=$string;
    $new = join "", map {sum0 split ""} $new =~ /(\d{1,$length})/g
	while length $new > $length;
    say "length $length, string $string -> $new"
}
