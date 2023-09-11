#!/usr/bin/raku

sub MAIN(
    *@ints
) {
    my %freq = @ints.classify({$_});

    say q{(},
        %freq
            .keys
            .sort({ %freq{$^a}.elems <=> %freq{$^b}.elems || $^b <=> $^a })
            .map({ | %freq{$_} })
            .join(q{,}),
        q{)};
}