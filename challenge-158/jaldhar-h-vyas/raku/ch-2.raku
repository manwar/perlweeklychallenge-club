#!/usr/bin/raku

sub MAIN() {
    my $y = 1;

    gather {
        loop {
            my $p = 3 * $y ** 2 + 3 * $y + 1;
            if $p > 1000 {
                last;
            }
            if ($p.is-prime) {
                take $p;
            }
            $y++;
        }
    }.join(q{, }).say;
}
