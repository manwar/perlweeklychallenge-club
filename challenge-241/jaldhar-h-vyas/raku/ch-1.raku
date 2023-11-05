#!/usr/bin/raku

sub MAIN(
    $diff, *@nums
) {

    @nums
        .combinations(3)
        .grep({
            my ($i, $j, $k) = @$_;

            $i < $j &&
            $j < $k &&
            $j - $i == $diff &&
            $k - $j == $diff;
        })
        .elems
        .say;
}