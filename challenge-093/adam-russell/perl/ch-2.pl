use strict;
use warnings;
##
# You are given a binary tree containing 
# only the numbers 0-9.
# Write a script to sum all possible paths 
# from root to leaf.
##
use Graph;

sub travserse_sum{
    my($tree) = @_;
    my @paths = build_paths($tree);
    my $path_sum = 0;
    for my $path (@paths){
        $path_sum +=  unpack("%32C*", pack("C*", @{$path})); 
    }
    return $path_sum;
}

sub build_paths {
   my ($graph) = @_;
   my @paths;
   local *_helper = sub{
      my $v = $_[-1];
      my @successors = $graph->successors($v);
      if(@successors){
         _helper(@_, $_) for @successors;
      } 
      else{
         push @paths, [@_];
      }
   };
   _helper($_) for $graph->source_vertices();
   return @paths;
}

MAIN:{
    my $Tree;
    $Tree = new Graph();
    $Tree->add_vertices(1, 2, 3, 4);
    $Tree->add_edge(1, 2);
    $Tree->add_edge(2, 3);
    $Tree->add_edge(2, 4);
    print travserse_sum($Tree) . "\n";
    
    $Tree = new Graph();
    $Tree->add_vertices(1, 2, 3, 4, 5, 6);
    $Tree->add_edge(1, 2);
    $Tree->add_edge(1, 3);
    $Tree->add_edge(2, 4);
    $Tree->add_edge(3, 5);
    $Tree->add_edge(3, 6);
    print travserse_sum($Tree) . "\n";
}
