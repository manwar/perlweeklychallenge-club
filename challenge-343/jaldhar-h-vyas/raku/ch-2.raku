#!/usr/bin/raku

sub MAIN(
    *@args
) {
    my @grid = @args.map({ $_.words».Int });
    my @wins = @grid.map({ [+] $_ });
    my $max  = @wins.max;
    my @candidates = @wins.keys.grep({ @wins[$_] == $max });
    my $champion = @candidates[0];

    for @candidates[1 .. *] -> $candidate {
        if @grid[$champion][$candidate] == 0 {
            $champion = $candidate;
        }
    }

    say $champion;
}
