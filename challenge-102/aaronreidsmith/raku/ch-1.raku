#!/usr/bin/env raku

sub digital-root(Int $N) returns Int {
    my @digits = $N.comb;
    my $digital-root = [+] @digits;
    while @digits.elems > 1 {
        @digits = $digital-root.comb;
        $digital-root = [+] @digits;
    }
    $digital-root;
}

sub is-rare(Int $N) returns Bool {
    return False if $N.comb.head % 2 != 0;
    return False if digital-root($N) ~~ 0|1|3|4|6|7;

    my $reversed   = $N.flip.Int;
    my $difference = $N - $reversed;

    if $difference >= 0 && $difference.sqrt.narrow ~~ Int {
        # Only calculate this if the difference is valid
        my $sum = $N + $reversed;
        $sum.sqrt.narrow ~~ Int;
    } else {
        False;
    }
}

sub challenge(Int $N) returns Str {
    my $min = ('2' ~ ('0' x $N - 1)).Int; # Rare number can never start with an odd digit.
    my $max = ('8' ~ ('9' x $N - 1)).Int; # Rare number can never start with an odd digit.
    ($min..$max).hyper.grep(&is-rare).join(', ');
}

multi sub MAIN(Int $N) {
    say challenge($N);
}

multi sub MAIN(Bool :$test, Bool :$vebose = False) {
    use Test;

    my @tests = (
        (1, '2, 8'),
        (2, '65'),
        (3, '242'),
        (4, ''),
        (5, '20402, 24642'),
        (6, '621770')
    );

    for @tests -> ($N, $expected) {
        is(challenge($N), $expected);
    }

    # This one is pretty slow, so it is not run by default
    if $vebose {
        is(challenge(9), '281089082');
    }

    done-testing;
}
