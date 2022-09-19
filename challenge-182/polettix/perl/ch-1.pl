#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

my @args = @ARGV ? @ARGV : (5, 2, 9, 1, 7, 6, 9);
say max_index(@args);

sub max_index (@args) {
   return (
      sort {
         $args[$a] <=> $args[$b] # sort ascending, BUT...
         || $b <=> $a            # be anti-stable if equal
      } (0 .. $#args)
   )[-1];
}
