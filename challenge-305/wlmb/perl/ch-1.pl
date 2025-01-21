#!/usr/bin/env perl
# Perl weekly challenge 305
# Task 1:  Binary Prefix
#
# See https://wlmb.github.io/2025/01/20/PWC305/#task-1-binary-prefix
use v5.36;
use Math::Prime::Util qw(is_prime);
die <<~"FIN" unless @ARGV;
    Usage: $0 B0 B1 B2...
    to test whether the binary substrings of the binary strings B0 B1...
    represet a prime number.
    FIN
for(@ARGV){
    warn("Expected a bunary string"), next unless /^[01]*$/;
    my @digits=split "";
    my @result;
    my $x=0;
    push @result, is_prime($x=2*$x+$_)?"t":"f" for (@digits);
    say "@digits -> @result";
}
