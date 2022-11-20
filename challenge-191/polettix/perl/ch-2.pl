#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

say cute_list(shift // 2);

sub cute_list ($n) {
   state sub cute_list_r ($count, $i, @items) {
      ++$count unless @items;
      my @pre = ();
      while (@items) {
         my $v = shift @items;
         if (! ($v % $i && $i % $v)) {
            $count = __SUB__->($count, $i + 1, @pre, @items);
         }
         push @pre, $v;
      }
      return $count;
   };
   cute_list_r(0, 1, 1 .. $n);
}
