#!/usr/bin/env perl

use strict;
use warnings;

use v5.22;

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

# If you try computing say 1000 of these, you get a mess without
# caching.  It gives deep recursion warnings and slowness.  So we use
# Memoize to speed this up.
use Memoize;

memoize('F');
sub F($n) {
    return 1 if $n == 0;
    return $n - M( F($n-1) );
}

memoize('M');
sub M($n) {
    return 0 if $n == 0;
    return $n - F( M($n-1) );
}

die("Must provide number of elements") if @ARGV != 1;
my $len = +$ARGV[0];

my @f = map { F($_) } (0..($len-1));
my @m = map { M($_) } (0..($len-1));

say "F: " . join(" ", @f);
say "M: " . join(" ", @m);

