#!/usr/bin/env perl

use 5.026;
use strict;
use autodie;
use warnings;
use List::Util qw(sum0);

for (my ($n, $count) = (2, 0); $count < 5; ++$n) {
    if ($n == sum0 grep {$n % $_ == 0} 1 .. $n/2) {
        say $n;
        ++$count;
    }
}
