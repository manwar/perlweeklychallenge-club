#!/bin/env raku

sub human-play(UInt:D \n --> UInt:D) {
    my UInt $pick;

    repeat {
        $pick = prompt "{ n } tokens left, please input number of tokens you take: ";
    } while $pick != 1|2|3 || $pick > n;
    put '';

    $pick;
}

sub computer-play(UInt:D \n --> UInt:D) {
    my UInt $pick = do given n {
        when n  < 4 { n }
        when n %% 4 { (1..3).pick }
        default     { n % 4 }
    };
    put "{ n } tokens left, I take $pick tokens.\n";

    $pick;
}

multi MAIN(UInt:D $n is copy, Bool:D \human-plays-first = True) {
    my Bool $human-won = True;

    while $n > 0 {
        given human-plays-first {
            when ?* {
                $n -= human-play($n);

                if $n > 0 {
                    $n -= computer-play($n);
                    $human-won = False if $n == 0;
                }
            }
            default {
                $n -= computer-play($n);

                if $n == 0 {
                    $human-won = False;
                } else {
                    $n -= human-play($n);
                }
            }
        }
    }

    put "{ $human-won ?? 'You' !! 'I' } won.";
}
