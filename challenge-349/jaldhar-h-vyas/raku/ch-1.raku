#!/usr/bin/raku

sub MAIN(
    $str
) {
    my $maxPower = 0;

    for $str.match(/(.)$0*/, :g) -> $match {
        my $power = $match.chars;
        if $power > $maxPower {
            $maxPower = $power;
        }
    }

    say $maxPower;
}