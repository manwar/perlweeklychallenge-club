#!/usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

use List::Util qw{ sum };

{   my %factorial = (0 => 1);
    $factorial{$_} = $factorial{ $_ - 1 } * $_ for 1 .. 10;

    sub is_factorion ($n) {
        sum(@factorial{ split //, $n }) == $n
    }
}

use Test::More tests => 5;

ok is_factorion(1);
ok is_factorion(2);
ok is_factorion(145);
ok is_factorion(40585);
ok ! is_factorion(125);
