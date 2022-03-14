#!/usr/bin/raku

sub MAIN() {
    my @fortunates;

    my $i = 0;
    while @fortunates.elems < 8 {
        my $pn = [*] (2  ... ∞).grep({ .is-prime; })[0 .. $i++];
        for $pn + 2 .. ∞ -> $m {
            if ($m.is-prime && $m - $pn ∉ @fortunates) {
                @fortunates.push($m - $pn);
                last;
            }
        }
    }

    @fortunates.sort.join(q{, }).say;
}