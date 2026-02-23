#!/usr/bin/raku

sub subtract($remainder, @results, $i) {
    state @fibs = (89, 55, 34, 21, 13, 8, 5, 3, 2, 1, 1);

    if $remainder == 0 {
        return @results;
    }

    my $nexti = $i;
    while @fibs[$nexti] > $remainder {
        $nexti++;
    }

    return subtract($remainder - @fibs[$nexti], (@results, @fibs[$nexti]).flat,
        $nexti + 2);
}

sub MAIN(
    Int $int where { 0 < $_ <= 100 } #= positive integer less than or equal to 100
) {
    subtract($int, (), 0).join(q{,}).say;
}
