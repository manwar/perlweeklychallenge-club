#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

sub ulam_iterator ($v, $w) {
   my @items = ($v, $w);
   my $n = 0;
   return sub {
      ITEM:
      while ($n > $#items) {
         my %count;
         for my $i (0 .. $#items - 1) {
            for my $j (reverse($i + 1 .. $#items)) {
               my $sum = $items[$i] + $items[$j];
               last if $sum <= $items[-1];
               $count{$sum}++;
            }
         }
         for my $new (sort { $a <=> $b } keys %count) {
            next unless $count{$new} == 1;
            push @items, $new;
            next ITEM;
         }
      }
      return $items[$n++];
   };
}

my @seeds = @ARGV == 2 ? @ARGV : (1, 2);
my $it = ulam_iterator(@seeds);
say join ', ', map { $it->() } 1 .. 10;
