use v5.36;
##
# You are given path to two folders, $source and $target.
# Write a script that recursively copy the directory structure 
# only (no files) from $source to $target.
##
use Graph;
use Cwd q/cwd/;
use File::Copy;
use Getopt::Long;
use Graph::Easy::Parser;

use constant ROOT_DIR => cwd();

sub display_directory_tree{
    my($graph) = @_;
    my @edges = $graph->edges();
    my @lines;
    for my $n (@edges){
        my ($u, $v) = @{$n};
        push @lines, "[ $u ] -- --> [ $v ]";
    }
    my $parser = Graph::Easy::Parser->new();
    my $graph_viz = $parser->from_text(join("", @lines));
    print $graph_viz->as_graphviz();
}

sub copy_folders{
    my($source, $target, $show_result) = @_;
    my $directory_graph = Graph->new();
    my @tree = split(/\//, $source);
    find_recurse($source, \$directory_graph);
    my @directories = $directory_graph->sink_vertices();
    my $root = ($directory_graph->source_vertices())[0]; 
    copy_directory($target, $_, $directory_graph) for $directory_graph->successors($root);
    if($show_result){
        chdir ROOT_DIR;
        $directory_graph = Graph->new();
        find_recurse($target, \$directory_graph);
        display_directory_tree($directory_graph);
    }
}

sub find_recurse{
    my($cwd, $directory_graph) = @_;
    opendir(CWD, $cwd); 
    my @files = readdir(CWD); 
    close(CWD); 
    do{
        my $f = $_;
        if(-d $cwd . q#/# . $f && $f ne q/./ && $f ne q/../){
            my @tree = split(/\//, $cwd);
            $$directory_graph->add_edge(pop @tree, $f);
            find_recurse($cwd . q#/# . $_, $directory_graph);
        }
    } for @files;
}

sub copy_directory{
    my($target, $source, $directory_graph) = @_; 
    chdir ROOT_DIR . q#/# . $target; 
    mkdir $source;
    $target .= q#/# . $source; 
    copy_directory($target, $_, $directory_graph) for $directory_graph->successors($source);
}

MAIN:{
    my($source, $target, $show_result);
    GetOptions(qq/source=s/ => \$source,
               qq/target=s/ => \$target,
               qq/show_result/ => \$show_result);
    copy_folders $source, $target, $show_result;
}