#!/usr/bin/perl
use 5.030;
use warnings;

sub unique {
    my ($arr) = @_;
    my %unique;
    for my $elem (@{$arr}) {
        $unique{$elem}++;
    }

    return keys %unique;
}

my @ints = @ARGV;
my %count;
map { $count{$_}++ } @ints;
say scalar values %count == scalar unique([values %count]) ? 1 : 0;
