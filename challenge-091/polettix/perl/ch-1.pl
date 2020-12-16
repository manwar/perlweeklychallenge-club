#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

sub count_number ($N) {
   my $retval = '';
   while (length $N) {
      my ($sequence, $char) = $N =~ m{((.)\2*)}mxs;
      my $n = length $sequence;
      $retval .= $n . $char;
      substr $N, 0, $n, '';
   }
   return $retval;
}

sub count_number_2 ($N) {
   my $len = length $N;
   my ($retval, $previous, $count) = ('', '', 0);
   for my $i (0 .. $len) {
      my $c = $i < $len ? substr($N, $i, 1) : '';
      if ($c eq $previous) { ++$count }
      else {
         $retval .= $count . $previous if $count;
         ($previous, $count) = ($c, 1);
      }
   }
   return $retval;
}

my $input = shift // '1122234';
say count_number($input);
say count_number_2($input);
