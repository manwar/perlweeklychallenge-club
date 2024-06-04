#!/usr/bin/raku

sub MAIN(
    $str
) {
    my @chars = $str.comb;
    my $score;

    for @chars.skip(1).keys -> $i {
        $score += (@chars[$i].ord - @chars[$i + 1].ord).abs;
    }

    say $score;
}