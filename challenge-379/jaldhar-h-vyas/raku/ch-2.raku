#!/usr/bin/raku

sub MAIN(
    $base,
    $limit
) {
    my @armstrongs;

    for 0 ..^ $limit -> $n {
        my $N = $n.base($base);
        my $power = $N.chars;

        if $N.comb.map({ $_.parse-base($base) ** $power }).sum == $n {
            @armstrongs.push($n);
        }
    }

    @armstrongs.join(q{, }).say;
}
