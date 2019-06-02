#!/usr/bin/env perl

use 5.010;
use strict;
use warnings;
use utf8;

use constant MAX_DISTINCT_DIGITS => 5;

my $n = 1;
while ($n) {
    my $square_number = $n ** 2;

    # See https://www.perlmonks.org/?node_id=240191
    my %digits;
    @digits{ split '', $square_number } = ();

    if (scalar keys %digits >= MAX_DISTINCT_DIGITS) {
        say $square_number;
        last;
    }

    $n++;
}

1;

__END__
$ perl ch1.pl
12769

# vi:et:sw=4 ts=4 ft=perl
