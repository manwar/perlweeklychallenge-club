#!/usr/bin/raku

sub MAIN(*@ints) {
    my %sorted = @ints.sort.kv.Hash.antipairs;
    say q{(}, @ints.map({ %sorted{$_} }).join(q{, }), q{)};
}
