#!/usr/bin/env perl6

for (100 .. Inf) -> $dividend {
    state $count;

    $dividend ~~ /^ (\d) \d+ (\d) $/;

    my $divisor = $0 ~ $1;

    if ($dividend %% $divisor) {
        say $dividend;
        $count++;
    }

    last if $count == 20;
}
