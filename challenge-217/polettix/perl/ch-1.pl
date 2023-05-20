#!/usr/bin/env perl
use v5.24;
use warnings;

my @matrix = map { [ split m{\s*,\s*}mxs ] } @ARGV;
say third_smallest(@matrix);

sub third_smallest {
   my @three_smallest;
   for my $row (@_) {
      for my $item ($row->@*) {
         my $idx = scalar(@three_smallest);
         --$idx while $idx > 0 && $three_smallest[$idx - 1] > $item;
         next if $idx > 2;
         splice(@three_smallest, $idx, 0, $item);
         pop(@three_smallest) while @three_smallest > 3;

      }
   }
   return $three_smallest[-1];
}
