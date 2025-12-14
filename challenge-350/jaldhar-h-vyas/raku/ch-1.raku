#!/usr/bin/raku

sub MAIN(
    $str
) {
    my $count = 0;

    for 2 ..^ $str.chars -> $i {
        my ($a, $b, $c) = $str.substr($i - 2, 3).comb;

        if $a ne $b && $a ne $c && $b ne $c {
            $count++;
        }
    }

    say $count;
}