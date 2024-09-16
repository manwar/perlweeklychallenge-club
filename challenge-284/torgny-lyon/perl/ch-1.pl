#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw(uniq);
use Test::More tests => 3;

sub get_lucky {
    foreach my $n (uniq sort { $b <=> $a } @_) {
        return $n if (grep { $_ == $n } @_) == $n;
    }
    return -1;
}

is(get_lucky(2, 2, 3, 4),        2);
is(get_lucky(1, 2, 2, 3, 3, 3),  3);
is(get_lucky(1, 1, 1, 3),       -1);
