#!/usr/bin/raku

sub MAIN(
    *@ints
) {
    my $max = -1;

    for @ints.combinations(3 .. @ints.elems) -> $combo {
        for @$combo.permutations().map({ $_.join }).grep({ $_ %% 3 }) -> $perm  {
            if $perm > $max {
                $max = $perm;
            }
        }
    }

    say $max;
}