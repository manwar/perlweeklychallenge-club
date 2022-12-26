#!/usr/bin/env raku
use v6;
sub MAIN (*@args) { say range-list(@args) }

sub range-list (@array) {
   gather {
      my ($begin, $end);
      for @array -> $v {
         if defined($end) && $end == $v - 1 {
            $end = $v;
         }
         else {
            take [$begin, $end] if defined($begin) && $begin < $end;
            $begin = $end = $v;
         }
      }
      take [$begin, $end] if defined($begin) && $begin < $end;
   }
}
