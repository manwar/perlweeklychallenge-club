#!/usr/bin/perl6

multi sub MAIN(Int $num) {
    my $multiple =
        ($num, $num + $num ... ∞).grep({ $_.Str ~~ / ^ <[01]>+ $ /; })[0];
    say $num, ' x ', $multiple / $num, ' = ', $multiple;
}