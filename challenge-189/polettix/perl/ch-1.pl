#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

my $target = shift;
say greater_character([@ARGV], $target);

sub greater_character ($array, $target) {
   (my $after_target = $target)++;
   my $retval = undef;
   for my $char ($array->@*) {
      next unless $char gt $target;
      $retval //= $char;
      $retval = $char if !defined($retval) || $char le $retval;
      last if $retval eq $after_target;
   }
   return $retval;
}
