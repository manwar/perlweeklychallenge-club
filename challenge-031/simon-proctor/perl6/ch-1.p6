#!/usr/bin/env perl6

use v6;

sub MAIN() {
    for ^25 {
        my $nu = (^100).pick() / 10;
        my $de = (^3).pick();

        say "{$nu} / {$de} safe? {safe-division($nu,$de)??"Yes"!!"No"}";
    }
}

sub safe-division( Numeric $nu, Numeric $de ) {
    try {
        ($nu/$de).Str();
        return True;
    }
    return False;
}
