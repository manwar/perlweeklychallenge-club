#!/usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

use Math::Prime::Util qw{ pn_primorial };

sub primorial_number ($n) {
    pn_primorial($n)
}

use Test::More tests => 5;

is primorial_number(0), 1;
is primorial_number(1), 2;
is primorial_number(2), 6;
is primorial_number(3), 30;
is primorial_number(4), 210;
