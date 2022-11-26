#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

sub flip {
    my $bin = "0b" . ( sprintf "%b", shift ) =~ tr[01][10]r;
    return oct $bin;
}

is_deeply( [ map { flip($_) } qw/ 5 4 6 / ], [ 2, 3, 1 ], "well fliped?" );

done_testing(1);
