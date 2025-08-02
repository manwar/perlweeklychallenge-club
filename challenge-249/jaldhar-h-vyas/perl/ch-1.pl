#!/usr/bin/perl
use 5.030;
use warnings;

my @ints = @ARGV;

my %elements;
for my $int (@ints) {
    $elements{$int}++;
}

my @output;
for my $k (keys %elements) {
    if (scalar $elements{$k} % 2 == 1) {
        say '()';
        exit;
    }

    for (0 .. $elements{$k} / 2 - 1) {
        push @output, [ $k, $k ];
    }
}

say join q{, }, map { q{(} . (join q{, }, @{$_} ) . q{)} } @output; 
