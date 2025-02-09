#!/usr/bin/raku

sub MAIN(
    *@ints
) {
    my @sorted = @ints.sort({ $^a <=> $^b });
    my @diffs;

    for @ints.keys -> $i {
        if @ints[$i] != @sorted[$i] {
            @diffs.push($i);
        }
    }

    say q{(}, @diffs.join(q{, }), q{)};
}
