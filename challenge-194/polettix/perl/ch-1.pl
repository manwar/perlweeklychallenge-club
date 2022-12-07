#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

@ARGV = qw< ?5:00 ?3:00 1?:00 2?:00 12:?5 12:5? > unless @ARGV;
say "$_ -> ", digital_clock($_) for @ARGV;

sub digital_clock ($input) {
   my $where = index($input, '?');
   return 9 if $where == 4;
   return 5 if $where == 3;
   return substr($input, 0, 1) == 2 ? 3 : 9 if $where == 1;
   return substr($input, 1, 1) < 4  ? 2 : 1;
}
