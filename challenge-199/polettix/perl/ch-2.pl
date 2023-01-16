#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

my ($x, $y, $z, @list) = @ARGV ? @ARGV : (7, 2, 3, 3, 0, 1, 1, 9, 7);
say good_triplets($x, $y, $z, @list);

sub good_triplets ($x, $y, $z, @list) {
   my $count = 0;
   for my $i (0 .. $#list - 2) {
      for my $j ($i + 1 .. $#list - 1) {
         next if abs($list[$i] - $list[$j]) > $x;
         for my $k ($j + 1 .. $#list) {
            next if abs($list[$j] - $list[$k]) > $y
                 || abs($list[$i] - $list[$k]) > $z;
            ++$count;
         }
      }
   }
   return $count;
}
