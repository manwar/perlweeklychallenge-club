use strict;
use warnings;
##
# You are given a binary tree. Write a script to 
# represent the given binary tree as an object and 
# flatten it to a linked list object. 
# Finally, print the linked list object.
##  
use Graph;
use LinkedList;

sub build_linked_list{ 
    my($tree) = @_;
    my $linked_list = new LinkedList(); 
    my @paths = build_paths($tree);
    my $root = $paths[0]->[0]; 
    my $next = $linked_list->insert($root, undef); 
    for my $path (@paths){
        for my $node (@{$path}){
            $next = $linked_list->insert($node, $next) if !$linked_list->in_list($node);    
        }
    } 
    return $linked_list;
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
         unshift @paths, [@_];
      }
   };
   _helper($_) for $graph->source_vertices();
   return @paths;
}

MAIN:{
    my $Tree;
    $Tree = new Graph();
    $Tree->add_vertices(1, 2, 3, 4, 5, 6, 7);
    $Tree->add_edge(1, 2);
    $Tree->add_edge(1, 3);
    $Tree->add_edge(2, 4);
    $Tree->add_edge(2, 5);
    $Tree->add_edge(5, 6);
    $Tree->add_edge(5, 7);
    print build_linked_list($Tree)->stringify();
}
