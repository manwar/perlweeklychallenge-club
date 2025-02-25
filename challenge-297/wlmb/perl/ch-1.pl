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
    from the binary (0's or 1's only) array N0 N1...
    FIN
my $result = max(                               # get largest
    map {$_->[0]}                               # get length
    grep {$_->[0]==2*$_->[1]}                   # select sublist
    map{
        my $f=$_;                               # start of list
        map {[$_+1-$f, sum0 @ARGV[$f .. $_]]}   # [start, length]
	grep {($_-$f)%2}                        # filter even lengths only
            $f+1 .. @ARGV-1                     # all possible remaining elements
    } 0..@ARGV-2                                # all possible first elements.
    )//0;                                       # default for empty case
say "@ARGV -> $result";
