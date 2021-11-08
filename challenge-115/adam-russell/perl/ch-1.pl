use strict;
use warnings;
##
# You are given an array of strings.
# Write a script to find out if the given strings can be chained to form a circle. 
# Print 1 if found otherwise 0.
# A string $S can be put before another string $T in circle if the last character 
# of $S is same as first character of $T.
##
use Graph;
use Graph::Easy::Parser;

sub build_graph{ 
    my @words; 
    my %first_letter_name; 
    my $graph = new Graph(); 
    while(my $s = <DATA>){
        chomp($s);
        my $first_letter = substr($s, 0, 1);      
        if($first_letter_name{$first_letter}){
            push @{$first_letter_name{$first_letter}}, $s;
        }
        else{
            $first_letter_name{$first_letter} = [$s]; 
        }  
        push @words, $s;   
    }
    for my $word (@words){
        $graph->add_vertex($word) if !$graph->has_vertex($word);
        my $child_nodes = $first_letter_name{substr($word, -1)};
        for my $n (@{$child_nodes}){
            $graph->add_vertex($n) if !$graph->has_vertex($n);
            $graph->add_weighted_edge($word, $n, (-1 * length($n))) if !$graph->has_edge($word, $n);   
            $graph->delete_edge($word, $n) if $graph->has_a_cycle(); 
        }  
    }   
    return $graph;
}

sub display_graph{
    my($graph) = @_;
    my $s = $graph->stringify();
    my @s = split(/,/, $s);
    my @lines;
    for my $n (@s){
        my @a = split(/-/, $n);
        push @lines, "[ $a[0] ] => [ ]" if @a == 1;
        push @lines, "[ $a[0] ] => [ $a[1] ]" if @a > 1;
    }
    my $parser = new Graph::Easy::Parser();
    my $graph_viz = $parser->from_text(join("", @lines));
    print $graph_viz->as_ascii();
}

MAIN:{
    my $graph = build_graph(); 
    my @cc = $graph->weakly_connected_components();  
    print "1\n" if @cc == 1;
    print "0\n" if @cc != 1;
    display_graph($graph);
}

__DATA__
abc
dea
cd
