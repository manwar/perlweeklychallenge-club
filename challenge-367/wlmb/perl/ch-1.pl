#!/usr/bin/env perl
# Perl weekly challenge 367
# Task 1:  Max Odd Binary
#
# See https://wlmb.github.io/2026/03/30/PWC367/#task-1-max-odd-binary
use v5.36;
use feature "try";
die <<~"FIN" unless @ARGV;
    Usage: $0 B0 B1...
    to find the largest odd binary number from the binary
    digits in the binary string Bn
    FIN
for(@ARGV){
    try {
        die "Only 0's and 1's allowed: $_" unless /^[01]*$/;
        die "At least one 1 required: $_" unless /1/;
        my $ones = grep $_, split "";
        my $zeroes=length()-$ones;
        say "$_ -> ", "1" x ($ones-1), "0" x $zeroes, "1";
    }
    catch($e){ warn $e; }
}
