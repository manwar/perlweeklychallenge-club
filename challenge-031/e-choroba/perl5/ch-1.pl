#!/usr/bin/perl
use warnings;
use strict;

use Try::Tiny;

sub division {
    my ($numerator, $denominator) = @_;
    try {
        { safe => 1, result => $numerator / $denominator }
    } catch {
        { safe => 0, error => $_ }
    }
}

use Test::More tests => 4;

ok division(1,2)->{safe};
ok !division(1,0)->{safe};

is division(1,2)->{result}, 1/2;
like division(1,0)->{error}, qr/Illegal division by zero/;
