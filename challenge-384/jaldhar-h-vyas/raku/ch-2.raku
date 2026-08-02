#!/usr/bin/raku

sub MAIN(
    $binary
) {
    my @results;

    for 0 ..^ $binary.chars -> $i {
        for 1 .. $binary.chars - $i -> $j {
            my $substring = $binary.substr($i, $j);
            if ($substring.match(/^ (0+) (1+) $/) || $substring.match(/^ (1+) (0+) $/))
            && $/[0].Str.chars == $/[1].Str.chars {
                @results.push($substring);
            }
        }
    }

    say q{(}, @results.map({ "\"$_\"" }).join(q{, }) , q{)};
}
