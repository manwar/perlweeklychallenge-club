#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';
use List::Util qw< min max >;

my $foo = [ split m{\s+}mxs, shift // '12-01 20-01' ];
my $bar = [ split m{\s+}mxs, shift // '15-01 18-01' ];
say days_together($foo, $bar);

sub days_together ($foo, $bar) {
   my $start = max(map { date_to_index($_->[0]) } ($foo, $bar));
   my $stop  = min(map { date_to_index($_->[1]) } ($foo, $bar));
   return max(0, $stop - $start + 1);
}

sub date_to_index ($date) {
   state $days_upto = [ days_upto() ];
   my ($d, $m) = map { $_ + 0 } split m{-}mxs, $date;
   return $days_upto->[$m - 1] + $d;
}

sub days_upto {
   my $sum = 0;
   map { $sum += $_ } qw< 0 31 28 31 30 31 30 31 31 30 31 30 31 >;
}
