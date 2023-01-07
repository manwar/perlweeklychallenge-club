#!/usr/bin/env raku
use v6;
sub MAIN (*@args) {
   @args = 2, 5, 8, 1 unless @args;
   put max-gap(@args);
}

sub max-gap (@list) {
   my $widest-gap = -1;
   my $count = 0;
   my @sorted = @list.sort: { $^a <=> $^b };
   for 1 ..^ @sorted -> $i {
      my $gap = @sorted[$i] - @sorted[$i - 1];

      # order of the following tests matters, do not change!
      ++$count                        if $gap == $widest-gap;
      ($count, $widest-gap) = 1, $gap if $gap >  $widest-gap;
   }
   return $count;
}
