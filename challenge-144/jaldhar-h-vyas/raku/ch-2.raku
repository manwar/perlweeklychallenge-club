#!/usr/bin/raku

sub MAIN(Int $u, Int $v) {
    my @ulams = $u, $v, $u + $v;

    while @ulams.elems < 10 {
        @ulams.push(
            @ulams
            .combinations(2)
            .map({ [+] $_; })
            .classify( { $_ }, into => my %freq )
            .keys
            .map({ $_.Int; })
            .grep({ %freq{$_}.elems < 2; })
            .grep({ $_ ∉ @ulams; })
            .min
        );
    }

    @ulams.join(q{, }).say;
}