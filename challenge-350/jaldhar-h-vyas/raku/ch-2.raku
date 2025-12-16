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
        my $shortest = @digits.sort.join;

        for 2 .. ∞ -> $j {
            my $candidate = $i * $j;
            if $candidate.chars > $i.chars {
                last;
            }

            if $candidate.comb.sort.join eq $shortest {
                $shufflePairs++;
                if $shufflePairs == $count {
                    $total++;
                    last;
                }
            }
        }
    }

    say $total;
}
