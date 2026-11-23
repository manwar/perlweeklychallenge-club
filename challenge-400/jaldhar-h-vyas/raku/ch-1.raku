#!/usr/bin/raku

sub MAIN(
    $int
) {
    my $biggestJump = 0;
    my @nonrepeating = (1 .. $int).grep({ $_ !~~ / (\d) .* $0 / });

    for 1 .. @nonrepeating.end -> $i {
        $biggestJump = max($biggestJump, @nonrepeating[$i] - @nonrepeating[$i - 1]);
    }

    say $biggestJump;
}
