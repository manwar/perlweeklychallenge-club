#!/usr/bin/perl
use 5.030;
use warnings;

my ($p, $w) = @ARGV;
my %count;
my @words = split /[\s\,\.]+/, $p;

for my $word (@words) {
    $count{$word}++;
}
delete %count{$w};

say [sort { $count{$b} <=> $count{$a} } keys %count]->[0];
