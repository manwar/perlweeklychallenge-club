#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(samerowcolumn([[1, 2, 3, 4], [2, 3, 4, 1], [3, 4, 1, 2], [4, 1, 2, 3]]), 1, 'example 1');
is(samerowcolumn([[1]]), 1, 'example 2');
is(samerowcolumn([[1, 2, 5], [5, 1, 2], [2, 5, 1]]), 0, 'example 3');
is(samerowcolumn([[1, 2, 3], [1, 2, 3], [1, 2, 3]]), 0, 'example 4');
is(samerowcolumn([[1, 2, 3], [3, 1, 2], [3, 2, 1]]), 0, 'example 5');

sub samerowcolumn($a) {
  foreach my $row (@{$a}) {
        my %notfound = map {$_ => 1} (1 .. scalar @{$row});
        foreach my $n (@{$row}) {
            delete $notfound{$n};
        }
        if (scalar %notfound > 0) {
            return 0;
        }
    }
    foreach my $coln (0 .. $#{$a->[0]}) {
        my %notfound = map {$_ => 1} (1 .. scalar @{$a});
        foreach my $row (@{$a}) {
            delete $notfound{$row->[$coln]};
        }
        if (scalar %notfound > 0) {
            return 0;
        }
    }
    1;
}
