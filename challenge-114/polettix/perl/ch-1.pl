#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

sub next_palindrome_number ($N) {
   my $l = length $N;
   return '1' . ('0' x ($l - 1)) . '1' unless $N =~ m{[0-8]}mxs;
   my $n = substr $N, 0, $l / 2;
   my $mid = $l % 2 ? substr($N, $l / 2, 1) : '';

   # just try to build straight from the inputs...
   if ((my $candidate = $n . $mid . reverse($n)) > $N) {
      return $candidate;
   }

   # if there's a "$mid", try increasing that
   if ($l % 2) {
      return $n . ($mid + 1) . reverse($n) if $mid != 9;
      $mid = 0;
   }

   ++$n;
   return $n . $mid . reverse($n);
}

@ARGV = (1234) unless @ARGV;
say next_palindrome_number($_) for @ARGV;
