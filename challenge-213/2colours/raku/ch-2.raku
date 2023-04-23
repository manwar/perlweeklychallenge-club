#!/usr/bin/env raku


subset Node of Int where * > 0;
my token node-id { <[1..9]><[0..9]>* }; # The task didn't say how nodes are represented - going with positive integers
my token route { '[' <node-id> ** 2..* % ',' ']' } # disallowing routes that lead nowhere
subset RouteList of Str where /^ '(' <route>* % ',' ')' $/;


sub BFS(%vertices, $source, $destination) {
  my SetHash() $traversed = $source;
  my @paths = ($source,),;
  while @paths {
    my @next-paths;
    for @paths -> $path {
      .return if .tail == $destination given $path;
      for keys %vertices{$path.tail} (-) $traversed -> $new-node {
        $traversed.set: $new-node;
        @next-paths.push: (|$path, $new-node);
      } 
    }
    @paths = @next-paths; 
  }
  Nil
}

sub MAIN(Str $routes, Node $source is copy, Node $destination is copy) {
  $source.=Int;
  $destination.=Int;
  die 'Please supply a valid list of routes.' unless $routes.subst(/\s/, '', :g) ~~ RouteList;
  my %vertices{Int};
  for $<route>>><node-id>>>.Int>>.rotor(2 => -1).flat -> $node1, $node2 { # for all antecedent node pairs
    %vertices{$node1}.push: $node2;
    %vertices{$node2}.push: $node1;
  }
  (BFS %vertices, $source, $destination andthen
    .join: ',' andthen
    "($_)" orelse 
    -1) andthen
    .say;
}
