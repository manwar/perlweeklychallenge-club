#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

say join ', ', farey_sequence(shift || 4);

sub farey_sequence ($n) {
   my @retval;
   my @cache = (0, 1, 1, $n);
   while ($cache[2] < $n) {
      my $k = int(($n + $cache[1]) / $cache[3]);
      push @cache, $k * $cache[2] - $cache[0], $k * $cache[3] - $cache[1];
      push @retval, join '/', splice @cache, 0, 2;
   }
   push @retval, '1/1';
   return @retval;
}
