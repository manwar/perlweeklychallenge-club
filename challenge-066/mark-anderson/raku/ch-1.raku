#!/usr/bin/env raku

sub MAIN(Int $M, Int $N where $N !== 0) {
    my $M-sign = $M.sign;
    my $N-sign = $N.sign;

    say divide($M.abs, $N.abs);

    sub divide($M is copy, $N) {
        state $quotient = 0;

        if $M > 0 {
            $quotient++;
            $M -= $N;
            divide($M, $N);
        }

        else {
            if $M-sign !== $N-sign {
                -$quotient;
            }

            else {
                $M == 0 ?? $quotient !! $quotient - 1;
            } 
        }
    }
}
