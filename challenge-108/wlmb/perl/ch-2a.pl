#!/usr/bin/env perl
# Perl weekly challenge 108
# Task 2: Bell numbers
# Complete enumeration.
#
# See https://wlmb.github.io/2021/04/12/PWC108/#task-2-bell-numbers
use warnings;
use strict;
use v5.12;

use Memoize;
memoize('bell');
my $last=shift @ARGV;
die "Usage: ./ch-2a.pl last\n to generate Bell numbers up to last>=0"
    unless defined $last and $last >=0;
foreach(0..$last){
    my $partitions=bell($_);
    my $bell=@$partitions;
    say "\nbell($_)=$bell";
    foreach my $p(@$partitions){
	print "\t";
	foreach(@$p){
	    print "{", join(",", @$_), "}";
	}
	say "";
    }
}
sub bell {
    my $n=shift;
    die "Argument of Bell should be non-negative" if $n<0;
    return [[[]]] if $n==0;
    return [[[1]]] if $n==1;
    my $previous=bell($n-1);
    my @with_new_set=map {[@$_, [$n]]} @$previous;
    my @with_new_element=map {
	my @sets=@$_; map {[@sets[0..$_-1], [@{$sets[$_]}, $n], @sets[$_+1..@sets-1]]}
	(0..@sets-1)} @$previous;
    my @current=(@with_new_set, @with_new_element);
    return [@current];
}
