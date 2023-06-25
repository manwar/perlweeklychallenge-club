#!/usr/bin/env raku
use v6;
sub MAIN (*@list) { put last-member(@list) }

sub last-member (Array(Int()) $list) {
   class BasicPriorityQueue { ... }
   my $pq = BasicPriorityQueue.new(
      items => $list,
      before => {$^a > $^b},
   );
   while ($pq.size() > 1) {
      my $x = $pq.dequeue;
      my $delta = $x - $pq.dequeue;
      $pq.enqueue($delta) if $delta;
   }
   return $pq.is-empty ?? 0 !! $pq.dequeue();
}

class BasicPriorityQueue {
   has @!items;
   has &!before;

   submethod BUILD (:&!before = {$^a < $^b}, :@items) {
      @!items = '-';
      self.enqueue($_) for @items;
   }

   #method dequeue ($obj) <-- see below
   method elems { @!items.end }
   # method enqueue ($obj) <-- see below
   method is-empty { @!items.elems == 1 }
   method size  { @!items.end }
   method top { @!items.end ?? @!items[1] !! Any }

   method dequeue () { # includes "sink"
      return unless @!items.end;
      my $r = @!items.pop;
      ($r, @!items[1]) = (@!items[1], $r) if @!items.end >= 1;
      my $k = 1;
      while (my $j = $k * 2) <= @!items.end {
         ++$j if $j < @!items.end && &!before(@!items[$j + 1], @!items[$j]);
         last if &!before(@!items[$k], @!items[$j]);
         (@!items[$j, $k], $k) = (|@!items[$k, $j], $j);
      }
      return $r;
   }

   method enqueue ($obj) { # includes "swim"
      @!items.push: $obj;
      my $k = @!items.end;
      (@!items[$k/2, $k], $k) = (|@!items[$k, $k/2], ($k/2).Int)
         while $k > 1 && &!before(@!items[$k], @!items[$k/2]);
      return self;
   }
}
