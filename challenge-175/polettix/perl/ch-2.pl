#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

use ntheory 'euler_phi';

my $n_items = shift // 20;
say
  for BruteCheck::brutechecker(
   iterator => BruteCheck::int_iterator('2..'),
   ender    => BruteCheck::max_size($n_items),
   checker  => sub ($n) { return totient_supersum($n) == $n },
  );

sub totient_supersum ($n) {
   state $cache = {0 => 0, 1 => 1, 2 => 1};

   # first "recurse" up to the point where we have something
   # in cache
   my @stack = $n;
   push @stack, $n = euler_phi($n) while ! exists $cache->{$n};

   # then go back down to calculate all new needed values
   $n = pop @stack;
   my $pred = $cache->{$n};
   while (@stack) {
      ($n, my $phi) = (pop(@stack), $n);
      $pred = $cache->{$n} = $phi + $pred;
   }

   # whatever is left is what we were after in the first place
   return $pred;
}

package BruteCheck;

sub max_size ($n) { sub ($aref) { $aref->@* >= $n } }

sub int_iterator ($spec) {
   my ($start, $stop, $step) = $spec =~ m{
      \A
         ([1-9]\d*|0|)
         \.\.
         ([1-9]\d*|0|)
         (?: / (-?[1-9]\d*))?
      \z
   }mxs;
   $start ||= 0;
   $step  ||= 1;

   my $i = $start;
   return sub {
      return
        if length($stop)
        && (($step > 0 && $i > $stop) || ($step < 0 && $i < $stop));
      my $retval = $i;
      $i += $step;
      return $retval;
   };
} ## end sub int_iterator ($spec)

sub brutechecker (%args) {
   my ($checker, $iterator, $ender) = @args{qw< checker iterator ender >};
   $iterator //= int_iterator('..');
   $ender //= sub { 0 };
   my @retval;
   while (!$ender->(\@retval) && defined(my $candidate = $iterator->())) {
      push @retval, $candidate if $checker->($candidate);
   }
   return @retval;
} ## end sub brutechecker (%args)
