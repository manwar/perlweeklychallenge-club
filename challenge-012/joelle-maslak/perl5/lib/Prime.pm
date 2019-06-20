#!/usr/bin/perl

use strict;
use warnings;
use v5.22;

package Prime 1.00;

use base 'Exporter';
our @EXPORT_OK = qw(int_isprime);

use Inline
  C    => 'DATA',
  name => 'Prime';

Inline->init();

1;

__DATA__
__C__

int isqrt(int y) {
    int x = 2;
    if (y < 4) { return 1; }

    while (1) {
        int new = (x+y / x) / 2;

        if (new-x == 1) {
            // We're in a cycle
            if ((x*x <= y) && (new*new > y)) {
                return x;
            }
        }
        if (x == new) { return x; }

        x = new;
    }
}

int int_isprime(int i) {
    int sqrt = isqrt(i);

    if (i <= 2) { return 1; } // Negatives are broken here
    if (i % 2 == 0) { return 0; }

    int div = 3;
    while (div <= sqrt) {
        if (i % div == 0) { return 0; }
        div += 2; // Just odds
    }

    return 1;
}

