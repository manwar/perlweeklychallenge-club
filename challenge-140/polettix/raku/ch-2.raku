#!/usr/bin/env raku
use v6;

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

sub MAIN (Int $i  = 2, Int $j = 3, Int $k = 4) {
   put multiplication-table($i, $j, $k);
}

sub multiplication-table (Int $i, Int $j, Int $k is copy) {
   die "out of range (too low!)\n" if $k == 0;
   die "out of range (too high!)\n" if $k > $i * $j;

   return $k if $k <= 2 || $k == $i * $j;
   return max($i * ($j - 1), ($i - 1) * $j) if $k == $i * $j - 1;

   my $pq = BasicPriorityQueue.new(
      items  => [[1, 1, 1],],
      before => { $^a[0] < $^b[0] },
   );
   my %seen = '1.1' => 1;
   while ($k > 1) {
      my $item = $pq.dequeue;
      my ($p, $I, $J) = $item.Slip;
      for [0, 1], [1, 0] -> $deltas {
         my $I_ = $I + $deltas[0];
         next if $I_ > $i;
         my $J_ = $J + $deltas[1];
         next if $J_ > $j;
         next if %seen{"$I_.$J_"}++;
         $pq.enqueue([$I_ * $J_, $I_, $J_]);
      }
      --$k;
   }
   my ($result) = $pq.dequeue;
   return $result;
}
