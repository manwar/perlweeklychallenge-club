#!/usr/bin/env raku

subset PositiveInt of Int where { $_ >= 0 }

sub challenge(@N) {
    my Int $pointer = 0;
    my Bool $reached-the-end;

    loop {
        given $pointer {
            when * < @N.elems - 1  {
                my $value = @N[$pointer];
                if $value == 0 {
                    $reached-the-end = False;
                    last;
                } else {
                    $pointer += @N[$pointer]
                }
            }
            when * == @N.elems - 1 {
                $reached-the-end = True;
                last;
            }
            when * > @N.elems - 1  {
                $reached-the-end = False;
                last;
            }
        }
    }

    $reached-the-end.Int;
}

multi sub MAIN(*@N where all(@N) ~~ PositiveInt) {
    say challenge(@N);
}

multi sub MAIN(:$test) {
    use Test;

    my @tests = (
        ((1, 2, 1, 2), 1),
        ((2, 1, 1, 0, 2), 0)
    );

    for @tests -> @test {
        is(challenge(@test[0]), @test[1]);
    }

    done-testing;
}
