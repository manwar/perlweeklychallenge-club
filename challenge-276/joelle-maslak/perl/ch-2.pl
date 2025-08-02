#!/usr/bin/perl

use JTM::Boilerplate 'script';
use List::Util qw(max);

MAIN: {
    my $numstr = join " ", @ARGV;
    $numstr =~ s/[(),]/ /g;
    $numstr =~ s/^\s*(.*)\s*$/$1/g;
    my (@nums) = split /\s+/, $numstr;

    my %counts;
    for my $v (@nums) {
        $counts{$v}++;
    }

    my %freqs;
    for my $k (keys %counts) {
        my $v = $counts{$k};
        $freqs{$v} //= [];
        push $freqs{$v}->@*, $k;
    }

    my $max = max keys %freqs;
    say $max*scalar($freqs{$max}->@*);
}
