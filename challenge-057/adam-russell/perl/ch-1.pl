use strict;
use warnings;
##
# Write a script to invert a binary tree.
##
use Graph;
use boolean; 
use Graph::Reader::Dot;
use Graph::Easy::Parser;

sub insert{
    my($graph, $root, $next) = @_;
    if(!$graph->vertices()){
        $graph->add_vertex($next);
        $graph->set_edge_attribute($next, "left", "left", true);
        $graph->set_edge_attribute($next, "right", "right", true);
        return $next; 
    } 
    if($root > $next){
        if($graph->has_edge_attribute($root, "left", "left")){
            $graph->delete_edge_attributes($root, "left");
            $graph->set_edge_attribute($root, $next, "left", true);
            $graph->set_edge_attribute($next, "left", "left", true);
            $graph->set_edge_attribute($next, "right", "right", true);
        } 
        my @successors = $graph->successors($root);
        for my $s (@successors){
            if($graph->has_edge_attribute($root, $s, "left")){
                insert($graph, $s, $next); 
            }  
        } 
    }  
    if($root < $next){
        if($graph->has_edge_attribute($root, "right", "right")){
            $graph->delete_edge_attributes($root, "right");
            $graph->set_edge_attribute($root, $next, "right", true);
            $graph->set_edge_attribute($next, "left", "left", true);
            $graph->set_edge_attribute($next, "right", "right", true);
        } 
        my @successors = $graph->successors($root);
        for my $s (@successors){
            if($graph->has_edge_attribute($root, $s, "right")){
                insert($graph, $s, $next); 
            }  
        } 
    }  
}


sub invert{
    my($graph, $root) = @_;
    my @successors = $graph->successors($root);
    for my $s (@successors){
        if($graph->has_edge_attribute($root, $s, "right")){
            $graph->delete_edge_attribute($root, $s, "right");
            $graph->delete_edge($root, $s);
            $graph->set_edge_attribute($root, $s, "left", true);
            invert($graph, $s); 
        }  
        elsif($graph->has_edge_attribute($root, $s, "left")){
            $graph->delete_edge_attribute($root, $s, "left");
            $graph->delete_edge($root, $s);
            $graph->set_edge_attribute($root, $s, "right", true);
            invert($graph, $s); 
        }  
    } 
}

sub display{
    my($graph) = @_;
    my @edges = $graph->edges();
    my @lines;
    for my $n (@edges){
        my ($u, $v) = @{$n};
        if($graph->get_edge_attribute($u, $v, "left")){ 
            push @lines, "[ $u ] -- left --> [ $v ]";
        }
        if($graph->get_edge_attribute($u, $v, "right")){ 
            push @lines, "[ $u ] -- right --> [ $v ]";
        }
    }
    my $parser = new Graph::Easy::Parser();
    my $graph_viz = $parser->from_text(join("", @lines));
    print $graph_viz->as_ascii();
    #print $graph_viz->as_graphviz();
}

MAIN:{
    my $graph = new Graph(multivertexed => true);
    my @a = (11, 6, 8, 19, 4, 10, 5, 17, 43, 49, 31);
    my $root;
    for my $a (@a){
        if(!$root){
            $root = insert($graph, $root, $a)
        }
        else{
            insert($graph, $root, $a)
        }
    }
    while($graph->has_vertex("left") && $graph->has_vertex("right")){
        $graph->delete_vertices("left", "right");
    }
    print "Original\n\n";
    display($graph);
    invert($graph, $root); 
    print "\n\nInverted\n\n";
    display($graph);
} 
