#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';
use List::Util 'sum';

say special_quadruplets(@ARGV);

sub special_quadruplets (@nums) {
   my $it = combinations_iterator(4, @nums);
   my $count = 0;
   while (my ($c, undef) = $it->()) {
      ++$count if sum($c->@[0..2]) == $c->[3];
   }
   return $count;
}

sub combinations_iterator ($k, @items) {
   my @indexes = (0 .. ($k - 1));
   my $n = @items;
   return sub {
      return unless @indexes;
      my (@combination, @remaining);
      my $j = 0;
      for my $i (0 .. ($n - 1)) {
         if ($j < $k && $i == $indexes[$j]) {
            push @combination, $items[$i];
            ++$j;
         }
         else {
            push @remaining, $items[$i];
         }
      }
      for my $incc (reverse(-1, 0 .. ($k - 1))) {
         if ($incc < 0) {
            @indexes = (); # finished!
         }
         elsif ((my $v = $indexes[$incc]) < $incc - $k + $n) {
            $indexes[$_] = ++$v for $incc .. ($k - 1);
            last;
         }
      }
      return (\@combination, \@remaining);
   }
}
