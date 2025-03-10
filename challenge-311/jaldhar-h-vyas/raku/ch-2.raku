#!/usr/bin/raku

sub MAIN(
    Str $str,
    Int $int where { $int < $str.chars }
) {
    my $sum = $str;

    while $sum.chars > $int {
        $sum = $sum.comb($int.Int).map({ $_.comb.sum }).join;
    }

    say $sum;
}
