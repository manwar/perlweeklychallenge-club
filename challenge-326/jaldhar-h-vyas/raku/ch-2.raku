#!/usr/bin/raku

sub MAIN(
    *@ints
) {
    my @decompressed;

    while @ints.elems {
        my ($i, $j) = @ints.splice(0, 2);
        @decompressed.push(| ($j x $i).comb);
    }

    say q{(}, @decompressed.join(q{, }), q{)};
}