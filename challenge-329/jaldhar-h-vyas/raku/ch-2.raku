#!/usr/bin/raku

sub MAIN(
    $str
) {
    my @substrings;

    for 0 .. $str.chars - 1 -> $i {
        for $i .. $str.chars -> $j {
            @substrings.push($str.substr($i, $j));
        }
    }

    for @substrings.unique.sort({ $^b.chars <=> $^a.chars }) -> $substring {
        $substring.comb.classify({$_ eq $_.lc ?? 'lower' !! 'upper'}, :into(my %case));

        if %case<lower>.values.unique.sort.join eq %case<upper>.values.unique.sort.join.lc {
            say $substring;
            last;
        }
    }
}