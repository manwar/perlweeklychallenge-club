#!/usr/bin/raku

sub MAIN(
    $from,
    $to,
    $count
) {
    my $total = 0;

    for $from .. $to -> $i {
        my $shufflePairs = 0;
        my @digits = $i.comb;
        if @digits != @digits.unique {
            next;
        }

        for @digits.permutations.map({ .join }) -> $j {
            if $j <= $i {
                next;
            }

            if $j %% $i {
                $shufflePairs++;
            }

            if $shufflePairs == $count {
                $total++;
                last;
            }
        }

    }

    say $total;
}
