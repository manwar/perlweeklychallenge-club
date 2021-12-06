use v6;

sub like_numbers (UInt $m, UInt $n) {
    my @digits = $m.comb;
    return grep { $_ %% $n },
        (@digits.combinations: 1..$m.chars-1)>>.join('');
}
for (1234, 2), (768, 4) -> $test {
    my @vals = like_numbers $test[0], $test[1];
    # say @vals; # -> [2 4 12 14 24 34 124 134 234]
    say "$test => ", @vals.elems;
}
