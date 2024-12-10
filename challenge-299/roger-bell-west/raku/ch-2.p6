#! /usr/bin/raku

use Test;

plan 3;

is(wordsearch([['A', 'B', 'D', 'E'], ['C', 'B', 'C', 'A'], ['B', 'A', 'A', 'D'], ['D', 'B', 'B', 'C']], 'BDCA'), True, 'example 1');
is(wordsearch([['A', 'A', 'B', 'B'], ['C', 'C', 'B', 'A'], ['C', 'A', 'A', 'A'], ['B', 'B', 'B', 'B']], 'ABAC'), False, 'example 2');
is(wordsearch([['B', 'A', 'B', 'A'], ['C', 'C', 'C', 'C'], ['A', 'B', 'A', 'B'], ['B', 'B', 'A', 'A']], 'CCCAA'), True, 'example 3');

sub encode($x, $y) {
    return Int($x * 64 + $y);
}

sub decode($z) {
    return [Int($z) div 64, $z % 64];
}

sub wordsearch(@grid0, $word0) {
    my %grid;
    for @grid0.kv -> $y, @row {
        for @row.kv -> $x, $c {
            %grid{encode($x, $y)} = $c;
        }
    }
    my @word = $word0.comb;
    for %grid.kv -> $start, $firstletter {
        if ($firstletter eq @word[0]) {
            my @queue = [Int($start), ];
            while @queue.elems > 0 {
                my @pos = (@queue.shift).flat;
                if @pos.elems == @word.elems {
                    return True;
                } else {
                    for ([0, 1], [1, 0], [0, -1], [-1, 0]) -> @dir {
                        my @lpos = decode(@pos[*-1]);
                        my @npos = [@lpos[0] + @dir[0], @lpos[1] + @dir[1]];
                        my $np = encode(@npos[0], @npos[1]);
                        if (%grid{$np}:exists &&
                                              !($np (elem) @pos) &&
                                              %grid{$np} eq @word[@pos.elems]) {
                            my @pp = @pos.clone;
                            @pp.push($np);
                            @queue.push(@pp);
                        }
                    }
                }
            }
        }
    }
    False;
}
