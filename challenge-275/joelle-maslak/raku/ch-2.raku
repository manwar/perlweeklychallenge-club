#!/usr/bin/env raku
use v6.d;

sub MAIN($input) {
    my $letter = "a";
    for $input.comb() -> $current {
        if ($current ~~ /^\d$/) {
            print chr(ord($letter) + $current);
        } else {
            print $current;
            $letter = $current;
        }
    }
    say "";
}