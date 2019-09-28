#!/usr/bin/perl6

sub deg2rad ($deg) {
    return $deg * (π / 180);
}

sub rad2deg($rad) {
    return $rad / (π / 180);
}

multi sub MAIN(*@ARGS) {
    my $sines = 0;
    my $cosines = 0;

    for @*ARGS -> $angle {
        $sines += sin deg2rad($angle);
        $cosines += cos deg2rad($angle);
    }

    $sines /= @*ARGS.elems;
    $cosines /= @*ARGS.elems;

    say rad2deg(atan2 $sines, $cosines).round;
}
