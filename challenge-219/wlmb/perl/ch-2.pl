#!/usr/bin/env perl
# Perl weekly challenge 219
# Task 2:  Travel Expenditure
#
# See https://wlmb.github.io/2023/05/29/PWC219/#task-2-travel-expenditure
use v5.36;
use List::Util qw(min);
die <<~"FIN" unless @ARGV > 3;
    Usage: $0 C1 C7 C30 D1 [D2...]
    to calculate the travel expenditure for days D1, D2...
    given the costs C1 C7 and C30 for one, seven and thirty day passes
    FIN
my @kinds=(1,7,30); # kinds of passes
my @days=@ARGV;
my @costs=splice @days, 0, 3;
my $expenditure=cost(0, @days);
say "Costs: @costs, Days: @days, Expenditure: $expenditure";

sub cost($current, @days){
    shift @days while @days and $current >= $days[0];
    return 0 unless @days;
    my $now=shift(@days);
    my $cost=min map {$costs[$_]+cost($now+$kinds[$_]-1, @days)} 0..2;
    return $cost;
}
