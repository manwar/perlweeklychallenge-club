#!/usr/bin/env raku
use v6;
sub MAIN (*@args) {
   my @triangle = @args».split(/ \, /)».Array;
   put triangle-sum-path(@triangle);
   put triangle-restricted-sum-path(@triangle);
}

sub triangle-sum-path (@triangle) { @triangle».min.sum }

sub triangle-restricted-sum-path (@triangle) {
   class Astar { ... }
   my $max-last = @triangle[*-1].max;
   my $astar = Astar.new(
      distance => sub ($u, $v) {
         return $v<goal> ?? 0 !! @triangle[$v<tier>][$v<index>];
      },
      successors => sub ($v) {
         my $tier = $v<tier> + 1;
         return hash(goal => 1) unless $tier <= @triangle.end;
         my @retval = gather {
            for 0 .. 1 -> $delta {
               my $index = $v<index> + $delta;
               take hash(tier => $tier, index => $index)
                  if $index <= @triangle[$tier].end;
            }
         };
         return @retval;
      },
      heuristic => sub ($u, $v) {
         return $u<goal> ?? 0 !! $u<tier> < @triangle.end ?? $max-last !! 0;
      },
      identifier => sub ($v) {
         return $v<goal> ?? 'goal' !! $v<tier index>.join(',');
      },
   );
   my $triangle-sum-path = $astar.best-path(
      hash(tier => 0, index => 0),
      hash(goal => 1),
   );
   my $sum = 0;
   for $triangle-sum-path.List -> $v {
      last if $v<goal>;
      $sum += @triangle[$v<tier>][$v<index>];
   }
   return $sum;
}

class Astar {
   has (&!distance, &!successors, &!heuristic, &!identifier);

   method best-path ($start!, $goal!) {
      my ($id, $gid) = ($start, $goal).map: {&!identifier($^a)};
      my %node-for = $id => {pos => $start, g => 0};
      class PriorityQueue { ... }
      my $queue = PriorityQueue.new;
      $queue.enqueue($id, 0);
      while ! $queue.is-empty {
         my $cid = $queue.dequeue;
         my $cx = %node-for{$cid};
         next if $cx<visited>++;

         return self!unroll($cx, %node-for) if $cid eq $gid;

         my $cv = $cx<pos>;
         for &!successors($cv) -> $sv {
            my $sid = &!identifier($sv);
            my $sx = %node-for{$sid} ||= {pos => $sv};
            next if $sx<visited>;;
            my $g = $cx<g> + &!distance($cv, $sv);
            next if $sx<g>:exists && $g >= $sx<g>;
            $sx<p> = $cid; # p is the id of "best previous"
            $sx<g> = $g;   # with this cost
            $queue.enqueue($sid, $g + &!heuristic($sv, $goal));
         }
      }
      return ();
   }

   submethod BUILD (:&!distance!, :&!successors!,
      :&!heuristic = &!distance, :&!identifier = {~$^a}) {}

   method !unroll ($node is copy, %node-for) {
      my @path = $node<pos>;
      while $node<p>:exists {
         $node = %node-for{$node<p>};
         @path.unshift: $node<pos>;
      }
      return @path;
   }

   class PriorityQueue {
      has @!items  = ('-');
      method is-empty { @!items.end < 1 }
      method dequeue () { # includes "sink"
         return if @!items.end < 1;
         my $r = @!items.end > 1 ?? @!items.splice(1, 1, @!items.pop)[0] !! @!items.pop;
         my $k = 1;
         while (my $j = $k * 2) <= @!items.end {
            ++$j if $j < @!items.end && @!items[$j + 1]<w> < @!items[$j]<w>;
            last if @!items[$k]<w> < @!items[$j]<w>;
            (@!items[$j, $k], $k) = (|@!items[$k, $j], $j);
         }
         return $r<id>;
      }
      method enqueue ($id, $weight) { # includes "swim"
         @!items.push: {id => $id, w => $weight};
         my $k = @!items.end;
         (@!items[$k/2, $k], $k) = (|@!items[$k, $k/2], ($k/2).Int)
            while $k > 1 && @!items[$k]<w> < @!items[$k/2]<w>;
         return self;
      }
   }
}
