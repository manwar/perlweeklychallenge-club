#!/usr/bin/env raku
use v6;

sub next-prime-after ($p) { # $p is prime
   state %nxt = 2 => 3, 3 => 5, 5 => 7, 7 => 11;
   state $max= 7;
   while ($p > $max) {
      $max= %nxt{$max};
      %nxt{$max} = $max+ 2;
      %nxt{$max} += 2 until %nxt{$max}.is-prime;
   }
   return %nxt{$p};
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

class A7 {
   has Int $!A = 2;
   method current () { $!A ** 7 }
   method move-on () { $!A = next-prime-after($!A) }
}

class A3B1 {
   has $!queue = BasicPriorityQueue.new(
      before => {$^a[2] < $^b[2]},
      items  => [[2, 3, 24, 0], [2, 3, 54, 1], ],
   );
   method current () { return $!queue.top[2] }
   method move-on () {
      my ($A, $B, $value, $twist) = $!queue.dequeue.Slip;
      my $next-B = next-prime-after($B);
      my @new = [$A, $next-B],; # this always appears
      my $next-A = next-prime-after($A);
      @new.push: [$next-A, $B]
         if $next-A < $B && next-prime-after($next-A) == $B; # fork!
      for @new -> $item {
         ($A, $B) = $item.Slip;
         $item.push: $twist ?? ($A * $B ** 3) !! ($A ** 3 * $B);
         $item.push: $twist;
         $!queue.enqueue($item);
      }
   }
}

class A1B1C1 {
   has $!queue = BasicPriorityQueue.new(
      before => {$^a[3] < $^b[3]},
      items  => [[2, 3, 5, 30], ]
   );
   method current() { return $!queue.top[3] }
   method move-on() {
      my ($A, $B, $C, $value) = $!queue.dequeue.Slip;
      my ($n-A, $n-B, $n-C) = ($A, $B, $C).map: {next-prime-after($^a)};
      my @new = [$A, $B, $n-C], ;
      @new.push: [$A, $n-B, $C] if $n-B < $C;
      @new.push: [$n-A, $B, $C] if $n-A < $B;
      for @new -> $item {
         ($A, $B, $C) = $item.Slip;
         $item.push: $A * $B * $C;
         $!queue.enqueue($item);
      }
   }
}

class EnumerateEighters {
   has $!a7     = A7.new();
   has $!a3b1   = A3B1.new();
   has $!a1b1c1 = A1B1C1.new();
   method get() {
      my $A = $!a7.current;
      my $B = $!a3b1.current;
      my $C = $!a1b1c1.current;
      my $retval = ($A, $B, $C).min;
      if ($retval == $A) { $!a7.move-on }
      elsif ($retval == $B) { $!a3b1.move-on }
      else { $!a1b1c1.move-on }
      return $retval;
   }
}

sub MAIN (Int $n = 10) {
   my $x = EnumerateEighters.new;
   $x.get.put for 1 .. $n;
}
