#!/usr/bin/perl
use 5.030;
use warnings;

sub min {
    my @arr = @_;
    my $lowest = 'inf';
    for my $i (@arr) {
        if ($i < $lowest) {
            $lowest = $i;
        }
    }

    return $lowest;
}

my ($letter, $str) = @ARGV;

my @chars = split //, $str;
my @j = grep { $chars[$_] eq $letter } keys @chars;
say q{(},
    (join q{,}, map { my $i = $_; min(map { abs($i - $_) } @j); } keys @chars),
    q{)};
