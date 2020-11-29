#!/usr/bin/env perl6

subset PositiveInt of Int where { $_ ~~ Int && $_ > 0 }

sub USAGE {
    print Q:c:to/EOH/;
    Usage: {$*PROGRAM-NAME} <list>

    Example: {$*PROGRAM-NAME} 1 2 3 4 5
EOH
}

sub MAIN(*@N where all(@N) ~~ PositiveInt && @N.elems > 0) {
    my $product = [*] @N;
    my @M = @N.map: $product / *;
    say @M;
}
