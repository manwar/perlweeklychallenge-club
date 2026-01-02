#!/usr/bin/raku

sub MAIN(
    $N
) {
    my @triples;

    for 1 .. $N -> $a {
        my $aSquared = $a²;
        my $b = $a + 1;

        while $a >= $N || $b <= $N {
            my $bSquared = $b²;
            my $sum = $aSquared + $bSquared;
            my $c = $sum.sqrt.Int;

            if $c == $b {
                last;
            }

            my @t = ( $a, $b, $c );
            if $sum == $c² && @t.any == $N {
                push @triples, @t;
            }

            $b++;
        }

    }

    @triples = @triples
        .map({ .sort({$^a <=> $^b}).join(q{-}) })
        .unique
        .map({ .split(q{-}) });
    say @triples
        ?? @triples.map({ q{(} ~ $_.join(q{, }) ~ q{)} }).join("\n")
        !! -1;
}