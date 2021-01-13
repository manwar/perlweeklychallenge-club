#!/usr/bin/env raku

# only positive
my $m = 5;
my $n = 2;

my $r = 0;
while $m >= $n {
    $m -= $n;
    $r++;
}

say $r;
