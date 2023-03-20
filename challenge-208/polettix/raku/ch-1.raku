#!/usr/bin/env raku
use v6;
sub MAIN (*@items) {
   my @lists = [], [];
   my $i = 0;
   for @items -> $item {
      if ($item eq '/') { $i = 1 }
      else { @lists[$i].push: $item }
   }
   say minimum-index-sum(@lists[0], @lists[1]);
}

sub minimum-index-sum ($list1, $list2) {
   my %list2-index-for = $list2.kv.reverse; # keeps minimum!
   my @result;
   my $min-sum = $list1.elems + $list2.elems; # beyond "possible"
   for @$list1.kv -> $i1, $item {
      defined(my $i2 = %list2-index-for{$item}) or next;
      my $this-sum = $i1 + $i2;
      if ($this-sum < $min-sum) { # new winner, reset
         @result = $item,;
         $min-sum = $this-sum;
      }
      elsif ($this-sum == $min-sum) { # append
         @result.push: $item;
      }
      else {} # just skip this
   }
   return @result;
}
