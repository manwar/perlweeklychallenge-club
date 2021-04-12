#!/usr/bin/env raku

sub challenge(Any $variable) returns Int {
    $variable.WHERE;
}

multi sub MAIN(Bool :$main) {
    my $variable = rand;
    say challenge($variable);
}

multi sub MAIN(Bool :$test) {
    use Test;

    my $variable = rand;
    is(challenge($variable), $variable.WHERE);

    done-testing;
}
