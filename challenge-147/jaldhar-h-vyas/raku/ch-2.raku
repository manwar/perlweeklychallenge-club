#!/usr/bin/raku

sub pentagon(Int $n) {
    return $n * (3 * $n - 1) / 2;
}

sub MAIN() {
    my %p;

    for 1_000 .. 3_000 -> $n {
        %p{pentagon($n)} = $n;
    }

    for %p.keys.combinations(2) -> @combo {
        if (%p{@combo[0] + @combo[1]}:exists) && (%p{(@combo[0] - @combo[1]).abs}:exists) {
            (%p{@combo[0]}, %p{@combo[1]})
                .join(q{, })
                .say;
            last;
        }
    }
}