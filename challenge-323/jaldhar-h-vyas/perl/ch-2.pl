#!/usr/bin/perl
use v5.38;

my ($income, @tax) = @ARGV;
my $taxed = 0;
my %taxes = map { my ($k, $v) = split /\s+/, $_; $k => $v } @tax;
my $total = 0;

for my $bracket ( sort { $a <=> $b } keys %taxes ) {
    if ($taxed >= $income) {
        last;
    }

    my $tax = ($bracket > $income ? $income : $bracket) - $taxed;
    $taxed += $tax;
    $total += $tax * ($taxes{$bracket} / 100);
}

say $total;
