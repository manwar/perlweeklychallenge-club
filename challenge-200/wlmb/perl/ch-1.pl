#!/usr/bin/env perl
# Perl weekly challenge 200
# Task 1:  Arithmetic Slices
#
# See https://wlmb.github.io/2023/01/16/PWC200/#task-1-arithmetic-slices
use v5.36;
use List::Util qw(uniq);
say(<<~"FIN"), exit unless @ARGV;
    Usage: $0 N1 [N2...]
    to find all arithmetic slices of the array N1 N2...
    FIN
my @in=@ARGV;
say "The arithmetic slices of [ ", join " ", @in, "] are\n[";
my @results=
    grep {
	my @m=@$_;
	my @diff;
	$diff[$_]=$m[$_+1]-$m[$_] for 0..@m-2;
	uniq(@diff)==1
    }
    map {
	my $start=$_;
	map {[@in[$start..$_]]}$start+2..@in-1
    } 0..@in-3;
say "    [@$_]" for @results;
say "]";
