#!/usr/bin/env raku

sub challenge($N) {
    my @digits = $N.comb.map(*.Int);

    my ($current-num, $current-count);
    my $first = True;
    my @output;
    for @digits.kv -> $index, $digit {
        # If this is the first round, just set our variables and continue
        if $first {
            $first = False;
            $current-num = $digit;
            $current-count = 1;
            next;
        }

        # Otherwise, just keep track of our current digit/count
        if $digit == $current-num {
            $current-count += 1;
        } else {
            @output.push($current-count);
            @output.push($current-num);
            $current-num = $digit;
            $current-count = 1;
        }

        # We need this to push the last number on, or it will get lost
        if $index == @digits.elems - 1 {
            @output.push($current-count);
            @output.push($current-num);
        }
    }

    @output.join;
}

multi sub MAIN($N where $N ~~ Int && $N > 0) {
    say challenge($N);
}

multi sub MAIN(:$test) {
    use Test;

    my @tests = (
        (1122234, 21321314),
        (2333445, 12332415),
        (12345, 1112131415)
    );

    for @tests -> @test {
        is(challenge(@test[0]), @test[1]);
    }

    done-testing;
}
