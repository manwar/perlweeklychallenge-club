#!/usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

use Math::Prime::Util qw{ is_prime };

sub pernicious_numbers ($n) {
    my @pn;
    for (my $i = 1; @pn < 10; ++$i) {
        push @pn, $i if is_pernicious_number($i);
    }
    return \@pn
}

sub is_pernicious_number ($i) {
    return is_prime(unpack '%32b*', pack 'N', $i)
}

use Test::More tests => 1;
is_deeply pernicious_numbers(10), [3, 5, 6, 7, 9, 10, 11, 12, 13, 14],
    '10 pernicious numbers';
