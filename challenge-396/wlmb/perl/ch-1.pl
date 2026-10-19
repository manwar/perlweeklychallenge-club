#!/usr/bin/env perl
# Perl weekly challenge 396
# Task 1:  Finishing Order
#
# See https://wlmb.github.io/2026/10/19/PWC396/#task-1-finishing-order
use v5.36;
use feature qw(try);
use List::UtilsBy qw(sort_by);
die <<~"FIN" unless @ARGV && @ARGV%2==0;
    Usage: $0 O0 F0 O1 F1...
    to find the order of arrival of our friends Fn given
    the order of arrival On. Fn and On are space separated lists
    of integers.
    FIN
for my ($order_string, $friends_string)(@ARGV){
    my ($order, $friends)=map {[split " "]} $order_string, $friends_string;
    my $i=1;
    my %map;
    $map{$_} = $i++ for @$order;
    for(@$friends){
	die "Friend is unknown: $_" unless defined $map{$_};
    }
    say"$order_string; $friends_string -> ",
	join " ", sort_by{$map{$_}} @$friends;
}
