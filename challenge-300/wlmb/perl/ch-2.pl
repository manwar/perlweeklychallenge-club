#!/usr/bin/env perl
# Perl weekly challenge 300
# Task 2:  Nested Array
#
# See https://wlmb.github.io/2024/12/15/PWC300/#task-2-nested-array
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 N0 N1...Nm
    to find the maximum cycle from the permutation N0...Nm of the numbers 0,1,...m
    FIN
my %all;
$all{$_}++ for @ARGV;
for(0..@ARGV-1){ # check the input is indeed a permutation
    die "Not a permutation" unless $all{$_};
}
my $max=0;
my %seen;
for(@ARGV){
    my @set;
    my $current=$_; # make a copy
    while(!$seen{$current}++){
	push @set, $current;
	$current=$ARGV[$current];
    }
    $max=@set if $max<@set;
}
say "@ARGV -> $max";
