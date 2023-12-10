#!/usr/bin/env raku

sub six-out-of-fortynine(Int $count where $count ∈ Set(1..49) = 6) {
    .say for pick($count, 1 .. 49);
}

#| Take user provided count like 7
multi sub MAIN(Int $count where $count ∈ Set(1..49) = 6) {
    six-out-of-fortynine($count);
}
