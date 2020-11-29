#!/usr/bin/env perl6

subset PositiveInt of Int where { $_ ~~ Int && $_ > 0 }

sub MAIN(*@N where all(@N) ~~ PositiveInt) {
    my $product = [*] @N;
    my @M = @N.map: $product / *;
    say @M;
}
