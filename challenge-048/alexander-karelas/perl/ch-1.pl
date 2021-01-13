#!/usr/bin/env perl

use v5.26;
use warnings;

my @people = (1 .. 50);

my $sword_at = 0; # array index

while (@people > 1) {
    if ($sword_at < $#people) {
        splice @people, $sword_at + 1, 1;
        $sword_at++;
    } else {
        splice @people, 0, 1;
        $sword_at = 0;
    }
}

say $people[0];