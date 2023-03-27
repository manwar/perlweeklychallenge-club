#!/bin/env raku

unit sub MAIN(*@N where @N.all ~~ Int);

loop {
    last if [≤] @N».sign;

    for ^(+@N-1) -> $i {
        if @N[$i].sign > @N[$i+1].sign {
            @N.splice(
                $i, 2, do given @N[$i].abs <=> @N[$i+1].abs {
                    when Order::Less { @N[$i+1] }
                    when Order::More { @N[$i] }
                    when Order::Same { [] }
                }
            );
            last;
        }
    }
}

put @N.join(', ');
