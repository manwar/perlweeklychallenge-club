#!/usr/bin/env perl
# Perl weekly challenge 323
# Task 2:  Tax Amount
#
# See https://wlmb.github.io/2025/05/26/PWC323/#task-2-tax-amount
use v5.36;
use List::Util qw(min);
die <<~"FIN" unless @ARGV && @ARGV%2==1;
    Usage: $0 I M1 P1 M2 P2...
    to compute taxes corresponding to income I where Mn is the maximum
    income in bracket n which is taxed with a percentage Pn
    FIN
my $income = shift;
my $low = 0; # lowest bound of current bracket
my @tax;
my $result=0;
my $remaining = $income;
for my ($high, $percentage)(@ARGV){
    push @tax, [$high, $percentage];
    my $range=$high-$low;
    $low=$high; # update for next iteration
    next if $remaining < 0;
    my $taxable = min($remaining, $range);
    $result += $taxable*$percentage/100;
    $remaining -= $taxable;
}
say "income=$income, tax=", join(", ", map{"[@$_]"} @tax)," -> $result";
