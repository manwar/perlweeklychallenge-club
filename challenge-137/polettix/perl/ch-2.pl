#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

sub maybe_lychrel ($n) {
   while ($n < 10_000_000) {
      my $r = reverse $n;
      return 0 if $n eq $r;
      $n += $r;
   }
   return 1;
}

say maybe_lychrel(shift || 196);
