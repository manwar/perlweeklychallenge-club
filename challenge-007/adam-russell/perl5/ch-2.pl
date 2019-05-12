use utf8; 
use strict;
use warnings;
##
# Given two input words and a file that contains an ordered word list, implement a 
# routine (e.g., find_shortest_ladder(word1, word2, wordlist)) that finds the shortest 
# ladder between the two input words. 
#
# A word ladder is a sequence of words [w_0, w_1, ..., w_n] such that each word w_i in 
# the sequence is obtained by changing a single character in the word wi-1. 
##
use Graph;
use boolean;
use constant OO => "∞";

sub build_graph{
    my($words) = @_;  
    my $graph = new Graph(undirected => true);
    foreach my $w0 (@{$words}){
        my $length_w0 = do{
            $w0 =~ tr/[a-z]//;
        };
        $graph->add_vertex($w0);
        foreach my $w1 (@{$words}){
            my $differences = eval "\$w1 =~ tr/$w0//";
            if(($length_w0 - $differences) == 1){
                $graph->add_vertex($w1) unless $graph->has_vertex($w1); 
                $graph->add_edge($w0, $w1) unless $graph->has_edge($w0, $w1);    
            }   
        }   
    }  
    return $graph; 
} 


sub dijkstra_sssp{
    my($graph, $source) = @_;
    my %paths;  
    my %total_edges;  
    no warnings "once";
    local *by_total_edges = sub {
        return 1 if $total_edges{$a} eq OO; 
        return -1 if $total_edges{$b} eq OO; 
        return $total_edges{$a} <=> $total_edges{$b};
    };   
    my @vertices = $graph->vertices();   
    foreach my $v (@vertices){
        $total_edges{$v} = OO;  
        $paths{$v} = $v;  
    } 
    $total_edges{$source} = 0;   
    while(@vertices){   
        @vertices = sort by_total_edges @vertices;  
        my $closest_vertex = shift @vertices;  
        foreach my $child_vertex ($graph->successors($closest_vertex)){
            if($total_edges{$child_vertex} eq OO){
                $total_edges{$child_vertex} = $total_edges{$closest_vertex} + 1; 
                $paths{$child_vertex} = $closest_vertex;   
            }  
        }   
    }   
    return \%paths;  
}  

sub find_shortest_ladder{
    my($source, $target, $words) = @_;  
    my $graph = build_graph($words); 
    my $paths=dijkstra_sssp($graph, $source);   
    foreach my $vertex ($graph->vertices()) {
        my @path; 
        my $next = $vertex;
        unshift @path, $next; 
        while ($next ne $source) { 
            $next = $paths->{$next};           
            unshift @path, $next; 
        }
        return join(" -> ", @path) if(($path[0] eq $source) && ($path[@path - 1] eq $target)); 
    } 
    return undef; 
} 

##
# Main  
##  
my @words = do{
    local $/; 
    my $words = <DATA>; 
    split(/\n/,$words);  
};   
my $ladder = find_shortest_ladder($words[0], $words[@words - 1], \@words);  
print "$ladder\n";

__DATA__
cold
cord
core
care
card
ward
warm
