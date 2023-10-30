#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';

my $cc = consistency_checker_for(shift);
say scalar grep { $cc->($_) } @ARGV;

sub consistency_checker_for ($string) {
   my %is_allowed = map { $_ => 1 } split m{}mxs, shift;
   return sub ($input) {
      for my $i (0 .. length($input) - 1) {
         return unless $is_allowed{substr($input, $i, 1)};
      }
      return 1;
   };
}
