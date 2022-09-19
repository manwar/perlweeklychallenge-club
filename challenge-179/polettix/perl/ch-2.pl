#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

my @n = @ARGV ? @ARGV : qw<  2 3 4 5 6 7 8 9 8 7 6 5 4 3 2  >;
binmode STDOUT, ':encoding(UTF-8)';
say sparkline_string(@n);

sub sparkline_string (@n) {
   state $sparks = [map { chr($_) } 0x2581 .. 0x2588];
   state $n_sparks = $sparks->@*;

   my ($min, $max) = @n[0, 0];
   for my $i (@n) {
      if ($i < $min)    { $min = $i }
      elsif ($i > $max) { $max = $i }
   }

   my @chars;
   if (my $delta = ($max - $min)) {
      my $scale = ($n_sparks - 1) / $delta;
      @chars = map { $sparks->[($_ - $min) * $scale] } @n;
   }
   else {
      @chars = ($sparks->[$n_sparks / 2]) x @n;
   }

   return join '', @chars;
}
