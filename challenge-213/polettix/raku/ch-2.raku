#!/usr/bin/env raku
use v6;

sub MAIN {
   my @routes = [1,2,3], [4,5,6], [3,8,9], [7,8];
   my $source = 1;
   my $destination = 6;
   my $route = shortest-route(@routes, $source, $destination) // -1;
   say $route;
}

class Dijkstra { ... }
class PriorityQueue { ... }

sub shortest-route (@routes, $src, $dst) {
   my $graph = routes-to-graph(@routes);
   my $d = Dijkstra.new(
      distance => { $graph{$^a}{$^b} },
      successors => { $graph{$^a}.keys },
      start => $src,
      goals => [ $dst ],
   );
   return $d.path-to($dst);
}

sub routes-to-graph (@routes) {
   my %adjacents_for;
   for @routes -> $route {
      my $prev = $route[0];
      for (1 ..^ @$route) -> $i {
         my $curr = $route[$i];
         %adjacents_for{$prev}{$curr} = %adjacents_for{$curr}{$prev} = 1;
         $prev = $curr;
      }
   }
   return %adjacents_for;
}

class Dijkstra {
   has %!thread-to is built; # thread to a destination
   has $!start     is built;     # starting node
   has &!id-of     is built;     # turn a node into an identifier

   method new (:&distance!, :&successors!, :$start!, :@goals,
         :$more-goals is copy, :&id-of = -> $n { $n.Str }) {
      my %is-goal = @goals.map: { &id-of($_) => 1 };
      $more-goals //= (sub ($id) { %is-goal{$id}:delete; %is-goal.elems })
         if %is-goal.elems;
      my $id = &id-of($start);
      my $queue = PriorityQueue.new(
         before => sub ($a, $b) { $a<d> < $b<d> },
         id-of  => sub ($n) { $n<id> },
         items  => [{v => $start, id => $id, d => 0},],
      );
      my %thr-to = $id => {d => 0, p => Nil, pid => $id};
      while ! $queue.is-empty {
         my ($ug, $uid, $ud) = $queue.dequeue<v id d>;
         for &successors($ug) -> $vg {
            my ($vid, $alt) = &id-of($vg), $ud + &distance($ug, $vg);
            next if ($queue.contains-id($vid)
               ?? ($alt >= (%thr-to{$vid}<d> //= $alt + 1))
               !! (%thr-to{$vid}:exists));
            $queue.enqueue({v => $vg, id => $vid, d => $alt});
            %thr-to{$vid} = {d => $alt, p => $ug, pid => $uid};
         }
      }
      self.bless(thread-to => %thr-to, :&id-of, :$start);
   }

   method path-to ($v is copy) {
      my $vid = &!id-of($v);
      my $thr = %!thread-to{$vid} or return;
      my @retval;
      while defined $v {
         @retval.unshift: $v;
         ($v, $vid) = $thr<p pid>;
         $thr = %!thread-to{$vid};
      }
      return @retval;
   }
   method distance-to ($v) { (%!thread-to{&!id-of($v)} // {})<d> }
}

class PriorityQueue {
   has @!items;
   has %!pos-of;
   has %!item-of;
   has &!before;
   has &!id-of;

   submethod BUILD (
      :&!before = {$^a < $^b},
      :&!id-of  = {~$^a},
      :@items
   ) {
      @!items = '-';
      self.enqueue($_) for @items;
   }

   method contains ($obj --> Bool) { self.contains-id(&!id-of($obj)) }
   method contains-id ($id --> Bool) { %!item-of{$id}:exists }
   method dequeue { self!remove-kth(1) }
   method elems { @!items.end }
   # method enqueue ($obj) <-- see below
   method is-empty { @!items.elems == 1 }
   method item-of ($id) { %!item-of{$id}:exists ?? %!item-of{$id} !! Any }
   method remove ($obj) { self.remove-id(&!id-of($obj)) }
   method remove-id ($id) { self!remove-kth(%!pos-of{$id}) }
   method size  { @!items.end }
   method top { @!items.end ?? @!items[1] !! Any }
   method top-id { @!items.end ?? &!id-of(@!items[1]) !! Any }

   method enqueue ($obj) {
      my $id = &!id-of($obj);
      %!item-of{$id} = $obj; # keep track of this item
      @!items[my $k = %!pos-of{$id} ||= @!items.end + 1] = $obj;
      self!adjust($k);
      return $id;
   }
   method !adjust ($k is copy) { # assumption: $k <= @!items.end
      $k = self!swap(($k / 2).Int, $k)
         while ($k > 1) && &!before(@!items[$k], @!items[$k / 2]);
      while (my $j = $k * 2) <= @!items.end {
         ++$j if ($j < @!items.end) && &!before(@!items[$j+1], @!items[$j]);
         last if &!before(@!items[$k], @!items[$j]); # parent is OK
         $k = self!swap($j, $k);
      }
      return self;
   }
   method !remove-kth (Int:D $k where 0 < $k <= @!items.end) {
      self!swap($k, @!items.end);
      my $r = @!items.pop;
      self!adjust($k) if $k <= @!items.end; # no adjust for last element
      my $id = &!id-of($r);
      %!item-of{$id}:delete;
      %!pos-of{$id}:delete;
      return $r;
   }
   method !swap ($i, $j) {
      my ($I, $J) = @!items[$i, $j] = @!items[$j, $i];
      %!pos-of{&!id-of($I)} = $i;
      %!pos-of{&!id-of($J)} = $j;
      return $i;
   }
}
