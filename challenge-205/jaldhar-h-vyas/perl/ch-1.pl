#!/usr/bin/perl
use 5.030;
use warnings;

sub unique {
    my (@array) = @{ $_[0] };
    my %unique;
    for my $elem (@array) {
        $unique{$elem}++;
    }

    return keys %unique;
}

my @array = sort { $b <=> $a } unique(\@ARGV);

say scalar @array > 2 ? $array[2] : $array[0];
