#!/usr/bin/perl
use 5.030;
use warnings;

my @array = @ARGV;

my @results = ();
@array = sort { $a <=> $b } @array;

for my $i (0 .. scalar @array - 3) {
    slice: for my $j ($i + 2 .. scalar @array - 1) {
        my @slice = @array[$i .. $j];
        my $diff = $slice[1] - $slice[0];
        for my $k (2 .. scalar @slice - 1) {
            if ($slice[$k] - $slice[$k - 1] != $diff) {
                last slice;
            }
        }
        push @results, \@slice;
    }
}

say q{(},
(
    join q{), (},
    (
        map { join q{, }, @{$_} } sort { scalar @{$a} <=> scalar @{$b} }
        @results
    )
),
q{)};
