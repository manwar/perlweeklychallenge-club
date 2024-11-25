#!/usr/bin/env perl
# Perl weekly challenge 297
# Task 1:  Contiguous Array
#
# See https://wlmb.github.io/2024/11/25/PWC297/#task-1-contiguous-array
use v5.36;
use List::Util qw(sum0 max all);
die <<~"FIN" unless @ARGV and all{$_==0 || $_==1}@ARGV;
    Usage: $0 N0 N1...
    to find the largest balanced contiguous sub array
    from the array N0 N1...
    FIN
my $result = max(
    map {$_->[0]}
    grep {$_->[0]==2*$_->[1]}
    map{
	my $f=$_;
        map {[$_+1-$f, sum0 @ARGV[$f .. $_]]}
	    $f+1 .. @ARGV-1
    } 0..@ARGV-2
    )//0;
say "@ARGV -> $result";
