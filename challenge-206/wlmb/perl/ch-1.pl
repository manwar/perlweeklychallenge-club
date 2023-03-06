#!/usr/bin/env perl
# Perl weekly challenge 206
# Task 1:  Shortest Time
#
# See https://wlmb.github.io/2023/02/27/PWC206/#task-1-shortest-time
use v5.36;
use List::Util qw(min);
die <<~"FIN" unless @ARGV;
    Usage: $0 T1 [T2...]HH:MM_2...
    to find the shortest time between the time points T1, T2...,
    each in the 24h format HH:MM
    FIN
my ($current, @rest)=sort {$a <=> $b} map {to_minutes($_)} @ARGV;
push @rest, $current + 24*60; # Add first time as last time, next day
my $min = min map {my $diff=$_-$current; $current=$_; $diff} @rest;
say join " ", @ARGV, "->", $min;

sub to_minutes($s){
    die "Wrong format, expected HH:MM: $s\n" unless $s=~/(\d\d?):(\d\d?)/;
    my ($hour, $min)=($1, $2);
    die "Hour should obey 0<=hour<24: $s" unless $hour<24;
    die "Minute should obey 0<=minute<60: $s" unless $min<60;
    return $hour*60+$min;
}
