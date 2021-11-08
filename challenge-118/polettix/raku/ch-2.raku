#!/usr/bin/env raku
use v6;

my $knight = (0, 0);
my @treasures = < 4 2 2 4 1 5 0 6 1 6 1 7 >.map({($^a, $^b)});
my $optimal = @*ARGS ?? True !! False;

my @path = adventure-of-knight($knight, @treasures, $optimal).flat;
@path.join(' ').put;
put @path.end, ' moves';

sub adventure-of-knight ($knight, @treasures, $optimal = False) {
   sub pos-to-pos ($p) {
      state @rows = (1..8).reverse;
      state @cols = 'a' .. 'h';
      return @cols[$p[0]] ~ @rows[$p[1]];
   }
   sub permutation-pass ($knight is copy, @treasures) {
      return gather {
         for @treasures -> $treasure {
            take path-between($knight, $treasure);
            $knight = $treasure;
         }
      }
   }
   my ($min_distance, @min_path);
   for permutations(@treasures) -> @perm {
      my @path = permutation-pass($knight, @perm).flat;
      my $distance = @path.map({$_.end}).sum;
      ($min_distance, @min_path) = ($distance, @path.Slip)
         if ! defined($min_distance) || $distance < $min_distance;
      last unless $optimal;
   }
   return gather {
      take pos-to-pos($knight) ~ '.N';
      for @min_path -> $sequence {
         my ($first, @rest) = @$sequence; # $first will be ignored
         my $treasure = @rest.pop;
         @rest.map({take pos-to-pos($_)});
         take pos-to-pos($treasure) ~ '.x';
      }
   }
}

sub path-between ($start, $stop) {
   sub same { ($^a <<->> $^b).map({$_²}).sum == 0 };
   return () if same($start, $stop);
   my $visited = SetHash.new();
   my @queue = (($start,),);
   while @queue.elems {
      my $subpath = @queue.shift;
      my ($x, $y) = @$subpath[*-1];
      for -2, 2 -> $long {
         for -1, 1 -> $short {
            for ($long, $short), ($short, $long) -> $pair {
               my ($X, $Y) = ($x + $pair[0], $y + $pair[1]);
               next unless (0 <= $X <= 7) && (0 <= $Y <= 7);
               my $pos = "$X,$Y";
               next if $visited{$pos};
               $visited.set($pos);
               my $newpath = ($subpath.Slip, ($X, $Y));
               return $newpath if same(($X, $Y), $stop);
               push @queue, $newpath;
            }
         }
      }
   }
   die 'no way';
}
