#!/usr/bin/raku

sub MAIN(
    Str $str,
) {
    my $base = q{`}.ord;
    my $result = $str.comb.map({ $_.ord - $base }).join;
    my $i = $k;

    while $i-- {
        $result = $result.comb.sum;
    }

    say $result;
}
