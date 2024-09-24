#! /usr/bin/raku

use Test;

plan 3;

is(contiguousblock([['x', 'x', 'x', 'x', 'o'], ['x', 'o', 'o', 'o', 'o'], ['x', 'o', 'o', 'o', 'o'], ['x', 'x', 'x', 'o', 'o']]), 11, 'example 1');
is(contiguousblock([['x', 'x', 'x', 'x', 'x'], ['x', 'o', 'o', 'o', 'o'], ['x', 'x', 'x', 'x', 'o'], ['x', 'o', 'o', 'o', 'o']]), 11, 'example 2');
is(contiguousblock([['x', 'x', 'x', 'o', 'o'], ['o', 'o', 'o', 'x', 'x'], ['o', 'x', 'x', 'o', 'o'], ['o', 'o', 'o', 'x', 'x']]), 7, 'example 3');

sub cencode($x, $y) {
    return Int($x * 1000000 + $y);
}

sub cdecode($c) {
    return [Int(($c+0) div 1000000), Int($c % 1000000)];
}

sub contiguousblock(@a) {
    my $y = @a.elems;
    my $x = @a[0].elems;
    my %starts = SetHash.new;
    for (0 .. $x - 1) -> $cx {
        for (0 .. $y - 1) -> $cy {
            %starts{cencode($cx, $cy)}++;
        }
    }
    my $maxblock = 0;
    while (%starts.elems > 0) {
        my $start = %starts.keys[0];
        my @cstart = cdecode($start);
        my @queue;
        my %visited = SetHash.new;
        %visited{$start}++;
        @queue.push($start);
        while (@queue.elems > 0) {
            my $here = @queue.shift;
            my @chere = cdecode($here);
            for ([-1, 0], [1, 0], [0, -1], [0, 1]) -> @delta {
                if ((@delta[0] >= 0 || @chere[0] > 0)
                    && (@delta[0] <= 0 || @chere[0] < $x - 1)
                    && (@delta[1] >= 0 || @chere[1] > 0)
                    && (@delta[1] <= 0 || @chere[1] < $y - 1)) {
                    my @cthere = [@chere[0] + @delta[0], @chere[1] + @delta[1]];
                    my $there = cencode(@cthere[0], @cthere[1]);
                    if (%visited{$there}:!exists &&
                        @a[@cthere[1]][@cthere[0]]
                        eq @a[@cstart[1]][@cstart[0]]) {
                        %visited{$there}++;
                        @queue.push($there);
                    }
                }
            }
        }
        my $size = %visited.elems;
        if ($size > $maxblock) {
            $maxblock = $size;
        }
        %starts = %starts (-) %visited;
    }
    return $maxblock;
}
