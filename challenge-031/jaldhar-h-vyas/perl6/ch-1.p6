#!/usr/bin/perl6

sub isDividedByZero($numerator, $denominator) {
        ($numerator / $denominator).grep({});

        CATCH {
            default {
                return True;
            }
        }

    return False;
}

sub MAIN(Int $numerator, Int $denominator) {
    say isDividedByZero($numerator, $denominator) ?? 'yes' !! 'no';
}