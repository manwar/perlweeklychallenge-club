#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';
sub consecutive_arrays (@args) {
   return unless @args;
   my $previous = $args[0];
   my @retval;
   for my $n (@args) {
      push @retval, [] if $n != $previous + 1;
      push $retval[-1]->@*, $n;
      $previous = $n;
   }
   return @retval;
}
my @input = @ARGV ? @ARGV : qw< 1 2 3 6 7 8 9 >;
my @output = consecutive_arrays(@input);
say '(', join(', ', map { local $" = ', '; "[$_->@*]" } @output), ')';
