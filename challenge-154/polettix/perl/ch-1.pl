#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

say for missing_permutations(@ARGV);

sub missing_permutations (@present) {
   my %present = map { $_ => 1 } @present;
   return grep {!$present{$_}++}
      map { join '', $_->@* }
      permutations(split m{}mxs, $present[0]);
}

sub permutations (@present) {
   my @indexes = 0 .. $#present;
   my @stack = (0) x @indexes;
   my @retval = [@present[@indexes]];
   my $sp = 0;
   while ($sp < @indexes) {
      if ($stack[$sp] < $sp) {
         my $other = $sp % 2 ? $stack[$sp] : 0;
         @indexes[$sp, $other] = @indexes[$other, $sp];
         push @retval, [@present[@indexes]];
         $stack[$sp]++;
         $sp = 0;
      }
      else {
         $stack[$sp++] = 0;
      }
   }
   return @retval;
}
