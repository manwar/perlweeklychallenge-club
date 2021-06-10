#!/usr/bin/env perl6
use v6;

# run <script> <number> <digit>

sub lastDigSumm($nr,$dig,$nrSummands) {
    return (($nr - $nrSummands * $dig) %% 10) && ($nrSummands * $dig <= $nr) && ($nrSummands * (($dig -1) * 10 + $dig) >= $nr);
}

sub lastDig($nr,$dig) {
    return (1..9).grep({ lastDigSumm($nr,$dig,$_) }).Bool;
}

sub sol($nr,$dig) {
    $dig == 0 && return ($nr >= 101 || ($nr %% 10));
    return (($nr >= $dig * 11) || lastDig($nr,$dig));
}

say sol(|@*ARGS.map(*.Int)).Int;


