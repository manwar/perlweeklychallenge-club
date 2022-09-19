#!/usr/bin/env raku
use v6;
sub MAIN (Int:D $n where * > 0 = 19) {
   my @disarium-numbers;
   my $length = 0;
   my $last = time;
   while @disarium-numbers < $n {
      ++$length;
      put "checking length $length...";
      @disarium-numbers.push: disariums-long-suffix($length).Slip;
      my $now = time;
      put "   {$now - $last}s {@disarium-numbers.elems} found so far ({@disarium-numbers.join(', ')})";
      $last = $now;
   }
   say @disarium-numbers;
   exit 0;
}

sub disarium-calc ($n) { $n.comb.kv.map(-> $x, $y { $y ** ($x + 1) }).sum }

multi sub disariums-long-suffix (1) { return [0 .. 9] }

multi sub disariums-long-suffix ($length, $suffix = '') {
   my @suffix = $suffix.comb.reverse;
   my $slen = $suffix.chars;
   my $residual = $length - $slen;

   my $baseline = 0; # only from suffix
   my $exp = $length;
   for @suffix -> $base { $baseline += $base ** $exp-- }
   my $max_increment = 0;
   while $exp > 0 { $max_increment += 9 ** $exp-- } # optimize probably?

   my $min_baseline = $baseline + 1; # 1000...NNN
   $min_baseline = (('1' x $residual) ~ $suffix).Int
      if $min_baseline.chars < $length;
   my $min_baseline_prefix = $min_baseline.substr(0, $residual).Int;
   my $min_baseline_suffix = $min_baseline.substr(*-$slen, $slen).Int;
   ++$min_baseline_prefix if $suffix < $min_baseline_suffix;
   $min_baseline = ($min_baseline_prefix ~ $suffix).Int;

   my $max_baseline = $baseline + $max_increment;
   my $n_digits = $max_baseline.chars;
   return [] if $n_digits < $length;
   my $max_baseline_prefix = $max_baseline.substr(0, $residual).Int;
   my $max_baseline_suffix = $max_baseline.substr(*-$slen, $slen).Int;
   $max_baseline_prefix-- if $suffix > $max_baseline_suffix;
   $max_baseline = ($max_baseline_prefix ~ $suffix).Int;

   my @collected;
   my $delta = $max_baseline_prefix - $min_baseline_prefix;
   if $delta > 10 {
      for (0 .. 9).reverse -> $digit {
         my $new_suffix = $digit ~ $suffix;
         my @children = disariums-long-suffix($length, $new_suffix);
         @collected.push: |@children;
      }
   }
   elsif $delta >= 0 {
      for $min_baseline_prefix .. $max_baseline_prefix -> $prefix {
         my $candidate = ($prefix ~ $suffix).Int;
         my $check = $baseline + disarium-calc($prefix);
         @collected.push: $candidate if $candidate == $check;
      }
   }
   return @collected;
}
