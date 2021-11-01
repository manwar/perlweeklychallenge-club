#!/usr/bin/raku

sub fib(Int $n) {
    return (gather {
        for (1, 1, -> $a, $b { $a + $b } ... *) -> $i {
            if ($i <= $n) {
                take $i;
            } else {
                last;
            }
        }
    })[1 .. *]
}

sub MAIN(
    Int $n #= an integer
) {
    my %sequences;

    for fib($n).combinations -> @fib {
        if ([+] @fib) == $n {
            %sequences{@fib.join(q{, })}++;
        }
    }

    say %sequences.elems;
}