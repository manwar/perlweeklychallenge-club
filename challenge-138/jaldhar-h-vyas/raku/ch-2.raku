#!/usr/bin/raku

sub MAIN(Int $n) {
    my $squareRoot = $n.sqrt;

    my $separated = ($n.comb Z~ ('-' xx $n.chars - 1)).join ~ $n.substr(*-1, 1);

    for (1 .. $n.chars - 1).combinations -> @positions {
        my $s = $separated;

        for @positions -> $i {
            $s.substr-rw(2 * $i - 1, 1) = q{};
        }

        my @parts = $s.split('-');
        if ([+] @parts) == $squareRoot {
            say 1;
            exit;
        }
    }

    say 0;
}
