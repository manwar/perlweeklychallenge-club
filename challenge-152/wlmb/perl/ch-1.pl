#!/usr/bin/env perl
# Perl weekly challenge 152
# Task 1: Minimum sum path
#
# See https://wlmb.github.io/2022/02/14/PWC152/#task-1-minimum-sum-path
use v5.12;
use warnings;
use List::Util qw(min sum0 all);
use Try::Tiny;
die "Usage: ./ch-1.pl T1 [T2]...\n"
    . "where Ti are triangles of the form '[[T00],[T10,T11],[T20,T21,T22]...'"
    unless @ARGV;
for my $triangle_string (@ARGV){
    try {
	my $triangle=eval $triangle_string;
	my @rows=@$triangle;
	# Seems unnecesary, but test shape
	die "Wrong row-size in $triangle_string"
	    unless all{$_+1==@{$rows[$_]}}(0..@rows-1);
	my @minima=map {min @$_} @rows;
	my $sum=sum0 @minima;
	say "Input: $triangle_string\nOutput: $sum\nPath values: ", join "-", @minima;
    }
    catch {
	say $_;
    }
}
