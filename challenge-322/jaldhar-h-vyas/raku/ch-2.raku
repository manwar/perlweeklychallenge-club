#!/usr/bin/raku

sub MAIN(
    *@ints
) {
    my %ranked;
    my $rank = 1;

    for @ints.sort({$^a <=> $^b}) -> $int {
        %ranked{$int} //= $rank++;
    }

    say q{(}, @ints.map({ %ranked{$_} }).join(q{, }), q{)};
}