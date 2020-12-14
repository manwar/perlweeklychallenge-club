#!/usr/bin/env raku

subset PositiveInt of UInt where * > 0;

multi MAIN(PositiveInt $N) {
    say count-number($N);
}

multi MAIN {
    use Test;
    plan 4;

    ok count-number(1122234) == 21321314,   "Example 1";
    ok count-number(2333445) == 12332415,   "Example 2";
    ok count-number(12345)   == 1112131415, "Example 3";
    ok count-number(11211)   == 211221,     "Repeated Number";
}

sub count-number(PositiveInt $N) {
    my $result;

    for $N ~~ m:g/ (<[1..9]>) $0* / {
         $result ~= .chars ~ .head;
    }

    $result;
}
