use strict;
use warnings;
##
# You are given a string $s.
# Write a script to create a Palindromic Tree for $s.
##
use Graph;
use boolean;
use Graph::Easy::Parser;

use constant EMPTY => 0;
use constant IMAGINARY => -1;

package EerTreeVertex{
    use Class::Struct;
    struct(
        start    => q/$/,
        end      => q/$/,
        length   => q/$/,
        suffix   => q/EerTreeVertex/,
        labelled => q/@/
    );
}
 
sub initialize{
    my $graph = new Graph(refvertexed => true);
    my $root_empty = new EerTreeVertex(
        length => EMPTY
    );
    my $root_imaginary = new EerTreeVertex(
        length => IMAGINARY
    );
    $graph->add_edge($root_empty, $root_imaginary);
    $graph->add_edge($root_imaginary, $root_imaginary);
    return $graph;
}

sub build_tree{
    my($s) = @_;
    my @letters = split(//, $s);
    my $eertree = initialize;
   
    return $eertree;
}

sub eertree{
    my($s) = @_;
    return build_tree($s);
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
    print eertree("redivider");
}