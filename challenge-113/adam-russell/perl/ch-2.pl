use strict;
use warnings;
##
# You are given a Binary Tree.
# Write a script to replace each node of the tree with 
# the sum of all the remaining nodes.
##
use Graph;
use Graph::Easy::Parser;

sub dfs_update{
    my($graph, $vertex, $graph_updated, $previous) = @_;      
    my @successors = $graph->successors($vertex); 
    for my $successor (@successors){
        my $sum_remaining = sum_remaining($graph, $vertex);   
        $graph_updated->add_edge($previous, $sum_remaining) if $previous;  
        dfs_update($graph, $successor, $graph_updated, $sum_remaining);   
    }    
    $graph_updated->add_edge($previous, sum_remaining($graph, $vertex)) if !@successors;  
}  

sub sum_remaining{
    my($graph, $visited) = @_;      
    my $sum = 0; 
    for my $vertex ($graph->vertices()){
        $sum += $vertex if $vertex != $visited;   
    }    
    return $sum;   
}  

sub display_graph{
    my($graph) = @_;
    my $s = $graph->stringify();
    my @s = split(/,/, $s); 
    my @lines;
    for my $n (@s){
        my @a = split(/-/, $n);
        push @lines, "[ $a[0] ] => [ $a[1] ]";  
    } 
    my $parser = new Graph::Easy::Parser(); 
    my $graph_viz = $parser->from_text(join("", @lines));
    print $graph_viz->as_ascii(); 
}

MAIN:{
    my $graph = new Graph();
    my $graph_updated = new Graph();
    my $root = 1;
    $graph->add_edge($root, 2); 
    $graph->add_edge($root, 3); 
    $graph->add_edge(2, 4); 
    $graph->add_edge(4, 7); 
    $graph->add_edge(3, 5); 
    $graph->add_edge(3, 6); 
    dfs_update($graph, $root, $graph_updated);
    display_graph($graph);
    display_graph($graph_updated);
}

