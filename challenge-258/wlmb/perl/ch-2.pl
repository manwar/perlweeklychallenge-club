#!/usr/bin/env perl
# Perl weekly challenge 258
# Task 2:  Sum of Values
#
# See https://wlmb.github.io/2024/02/26/PWC258/#task-2-sum-of-values
use v5.36;
use List::Util qw(sum0);
die <<~"FIN" unless @ARGV;
    Usage: $0 K N0 [N1...]
    to sum the values of Nm whose index m has K ones in its binary representation
    FIN
my ($k,@int)=@ARGV;
# Convert to binary, add ones and compare to $k to filter indices
my @indices=grep {$k==sum0 split "", sprintf "%b",$_}0..@int-1;
my $result=sum0 @int[@indices];
say "k=$k, ints=@int -> ", $result;
