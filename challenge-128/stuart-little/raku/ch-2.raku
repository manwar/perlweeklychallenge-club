#!/usr/bin/env raku
use v6;

# run <script> <starting arrivals followed by departures, all space-separated>

my @times = (@*ARGS Z [0..^@*ARGS.elems]).map({ [$_[0], $_[1] % (floor(@*ARGS.elems/2))] }).sort({ $_[0] });
my $sol=0; 
my @station = 0 xx floor(@*ARGS/2);

for (@times) {
    @station[$_[1]]+^=1;
    (@station.sum > $sol) && do {$sol = @station.sum};
}

say $sol;
