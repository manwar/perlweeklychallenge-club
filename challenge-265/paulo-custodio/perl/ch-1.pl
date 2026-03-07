#!/usr/bin/env perl

use Modern::Perl;

my @ints = @ARGV;
say freq_33(@ints);

sub freq_33 {
    my(@ints) = @_;
    my %count; $count{$_}++ for @ints;
    for my $n (sort {$a <=> $b} keys %count) {
        return $n if $count{$n}/scalar(@ints) >= 1/3;
    }
    return "''";
}
