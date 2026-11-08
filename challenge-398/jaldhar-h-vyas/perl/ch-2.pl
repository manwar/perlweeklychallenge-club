#!/usr/bin/perl
use 5.40.1;
use warnings;

my @words = @ARGV;
my %groups;

for my $word (@words) {
    my @ords = map { ord } split //, $word;
    my @difference;

    for my $i (1 .. scalar @ords - 1) {
        push @difference, $ords[$i] - $ords[$i - 1];
    }

    my $signature = join q{,}, @difference;
    $groups{$signature} //= [];
    push @{$groups{$signature}}, $word;
}

for my $group (values %groups) {
    if (scalar @{$group} == 1) {
        say $group->[0];
        last;
    }
}
