#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

sub next_permutation (@arrangement) {
   my $i = $#arrangement - 1;
   --$i while $i >= 0 && $arrangement[$i] >= $arrangement[$i + 1];
   return unless $i >= 0;
   my $end = my $j = $#arrangement;
   --$j while $arrangement[$i] >= $arrangement[$j];
   @arrangement[$i, $j] = @arrangement[$j, $i];
   @arrangement[$i + 1 .. $end]  = reverse @arrangement[$i + 1 .. $end];
   return @arrangement;
}

sub pandigital_numbers ($n = 5, $b = 10) {
   my ($n_digits, $factorial) = (1, 1);
   $factorial *= ++$n_digits while $factorial < $n;
   die "I'm too lazy for more general algorithms"
      if $n_digits >= $b - 1;

   state $p36_min = '1023456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
   my $fix = substr $p36_min, 0, $b - $n_digits;
   my @moving = split m{}mxs, substr $p36_min, $b - $n_digits, $n_digits;
   map {
      @moving = next_permutation(@moving) if $_;
      join '', $fix, @moving;
   } 0 .. $n - 1;
}

say for pandigital_numbers(@ARGV);
