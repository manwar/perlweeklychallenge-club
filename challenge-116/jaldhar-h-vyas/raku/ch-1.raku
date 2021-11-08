#!/usr/bin/raku

sub MAIN(
    Int $N where { $N >= 10; } #= integer greater than 9
) {
    my $found = True;

    for 1 .. $N.chars / 2 -> $len {
        $found = True;

        my $n =  '0' x ($N.chars % $len) ~ $N;
        my @digits = $n.comb($len);
        for 1 ..^ @digits.elems -> $group {
            if @digits[$group].substr(0, 1) == '0' || @digits[$group] - @digits[$group - 1] != 1 {
                $found = False;
                last;
            }
        }

        if $found {
            say @digits.map({ s/^0//; $_; }).join(q{,});
            exit;
        }
    }

    if !$found {
        say $N;
    }
}