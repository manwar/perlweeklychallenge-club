#!/usr/bin/env raku
use v6;
sub MAIN (*@n) { put summations(@n) }

sub summations (@n is copy) {
   for 2 .. @n.end { @n[$_] += @n[$_ - 1] for $_ .. @n.end }
   return @n[*-1];
}
