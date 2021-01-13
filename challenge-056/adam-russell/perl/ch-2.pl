use strict;
use warnings;
##
# You are given a binary tree and a sum, write 
# a script to find if the tree has a path such 
# that adding up all the values along the path 
# Only complete paths (from root to leaf node)
# may be considered for a sum.
##
use Graph;
use boolean; 
use Graph::Easy::Parser;

use constant SUM => 35;

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

sub find_path_sum{
    my($graph, $sum, $path) = @_;
    my $parent = $path->[-1];
    my @children = $graph->successors($parent); 
    for my $v (@children){
        push @{$path}, $v;
        my $total = unpack("%32C*", pack("C*", @{$path})); 
        if($total == $sum && $graph->is_sink_vertex($v)){
            return $path; 
        }
        else{
            my @p = @{$path};
            $path = find_path_sum($graph, $sum, \@p) if @p;  
            if($path){
                my $total = unpack("%32C*", pack("C*", @{$path})); 
                return $path if $total == $sum;
            }
        }
    }  
}

sub display_path{
    my($graph, $path) = @_;
    my $s = $graph->stringify();
    for my $v (@{$path}){
        my $v_ = "$v*"; 
        $s =~ s/$v/$v_/g; 
    } 
    my @s = split(/,/, $s); 
    my @lines;
    for my $n (@s){
        my @a = split(/-/, $n);
        push @lines, "[ $a[0] ] => [ $a[1] ]";  
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
    my $path = find_path_sum($graph, SUM, [$root]);
    display_path($graph, $path); 
}

__END__
11*-19,11-6*,19-17,19-43,4-5,43-31,43-49,6-4,6-8*,8-10*
