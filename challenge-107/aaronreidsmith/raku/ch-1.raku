#!/usr/bin/env raku

sub challenge(Int $n) returns Str {
    my @output;
    for (^∞) -> $i {
        my @digits = $i.comb;
        my $valid = True;
        for @digits.kv -> $index, $value {
            $valid = @digits.grep($index).elems == $value;
            last unless $valid;
        }
        @output.push($i) if $valid;
        last if @output.elems == $n;
    }
    @output.join(', ');
}

multi sub MAIN(Int $n = 3) {
    say challenge($n);
}

multi sub MAIN(Bool :$test) {
    use Test;

    is(challenge(3), '1210, 2020, 21200');

    done-testing;
}
