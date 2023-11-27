#!/usr/bin/raku

sub MAIN(
    *@int
) {
    my %s;
    for @int.sort Z=> @int.keys -> $p {
        unless %s{$p.key}:exists {
            %s{$p.key} = $p.value;
        }
    }
    say q{(}, @int.map({ %s{$_} }).join(q{, }), q{)};
}