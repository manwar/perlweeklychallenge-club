#!/usr/bin/env raku

# Used for testing
class Calc {
    method add {}
    method mul {}
    method div {}
}

sub challenge(Any $class) returns Str {
    $class.^methods.map(*.gist).join("\n");
}

multi sub MAIN(Bool :$main) {
    say challenge(Calc.new);
}

multi sub MAIN(Bool :$test) {
    use Test;

    my $test-class = Calc.new;

    is(challenge($test-class), "add\nmul\ndiv\nBUILDALL");

    done-testing;
}
