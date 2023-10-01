#!/usr/bin/env raku
use v6;

class UnionFind {
   has $.count = 0;
   has %!cs;
   has &!id-of is built;
   has @!items;

   method add ($item) {
      my $id = &!id-of($item);
      return self if %!cs{$id};
      %!cs{$id} = [ $id, $item, 1 ];
      $!count++;
      return self;
   }

   method find ($item) { %!cs{self.find-id($item)}[1] }

   method find-id ($item) {
      my $r = my $i = &!id-of($item);
      return unless %!cs{$r}:exists;
      $r = %!cs{$r}[0] while $r ne %!cs{$r}[0];
      ($i, %!cs{$i}) = (%!cs{$i}[0], %!cs{$r}) while $i ne $r;
      return $r;
   }

   method new (:&id-of = -> $n { $n.Str }, :@components) {
      my $obj = self.bless(:&id-of);
      $obj.add($_) for @components;
      return $obj;
   }

   method union ($p, $q) {
      my ($i, $j) = self.find-id($p), self.find-id($q);
      return self if $i eq $j;
      ($i, $j) = $j, $i if %!cs{$i}[2] < %!cs{$j}[2]; # i -> max
      %!cs{$i}[2] += %!cs{$j}[2];
      %!cs{$j} = %!cs{$i};
      $!count--;
      return self;
   }
}

sub MAIN (*@indexes) {
   @indexes = @indexes.map({.split(/\D+/)}).flat;
   my $uf = UnionFind.new(components => [ ^@indexes ]);
   for @indexes.kv -> $i, $j { $uf.union($i, $j) }
   put $uf.count;
}
