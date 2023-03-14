#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';

say h_index(@ARGV);

sub h_index (@citations) {
   @citations = reverse sort { $a <=> $b } grep { $_ } @citations;
   $_ < $citations[$_] || return $_ for 0 .. $#citations;
   return scalar(@citations);
}
