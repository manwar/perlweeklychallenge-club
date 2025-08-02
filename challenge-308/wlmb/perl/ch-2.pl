#!/usr/bin/env perl
# Perl weekly challenge 308
# Task 2:  Decode XOR
#
# See https://wlmb.github.io/2025/02/10/PWC308/#task-2-decode-xor
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 I E_0 E_1...E_n
    to decode the sequence  E_j=Oj^O_{j+1} and find the original sequence
    O_j, j=0..n+1 given its starting value I
    FIN
push my @original, my $initial=shift;
push @original, $original[-1]^$_ for @ARGV;
say "initial=$initial, encoded=@ARGV -> @original"
