#!/usr/bin/env perl
# Perl weekly challenge 213
# Task 2:  Shortest Route
#
# See https://wlmb.github.io/2023/04/17/PWC213/#task-2-shortest-route
use v5.36;
use List::UtilsBy qw(min_by);
die <<~"FIN" unless @ARGV >= 3;
    Usage: $0 start dest R1 [R2...]
    to find shortest route from start to dest following the routes R1 R2...
    Each route is specified as a space separated string of node labels
    FIN
my $start=shift;
my $dest=shift;
my @routes=map {[split " "]} @ARGV;
my %neighbors;
for my $r(@routes){ # set table of neighbors
    $neighbors{$r->[$_]}{$r->[$_+1]}=$neighbors{$r->[$_+1]}{$r->[$_]}=1 for 0..@$r-2;
}
my %distance_from;
my @nodes=([$dest,0]);
while(my $n=shift @nodes){
    my ($current, $distance)=@$n;
    $distance_from{$current}=$distance;
    push @nodes, map {[$_, $distance+1]}
                 grep {not defined $distance_from{$_}}
                 keys %{$neighbors{$current}};
}
my @shortest;
push @shortest, my $current=$start if defined $distance_from{$start};
push @shortest, $current=min_by {$distance_from{$_}} grep {defined $distance_from{$_}}
    keys %{$neighbors{$current}} while(defined $current && $current!=$dest);
say @shortest?(join " ", @shortest):"No solution";
