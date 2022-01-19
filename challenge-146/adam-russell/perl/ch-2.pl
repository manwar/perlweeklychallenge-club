use strict;
use warnings;
##
# Given a fraction return the parent and grandparent of
# the fraction from the Curious Fraction Tree.
##
use Graph;

use constant ROOT => "1/1";
use constant SEPARATOR => "/";

sub initialize{
    my($member) = @_;
    my $graph = new Graph();
    $graph->add_vertex(ROOT);
    my @next = (ROOT);
    my @changes = ([0, 1], [1, 0]);
    my $level = 0;
    {
        my @temp_next;
        my @temp_changes;
        do{
            $level++;
            my $next = shift @next;
            my($top, $bottom) = split(/\//, $next);
            my $change_left = shift @changes;
            my $change_right = shift @changes;
            my $v_left = ($top + $change_left->[0]) . SEPARATOR . ($bottom + $change_left->[1]);
            my $v_right = ($top + $change_right->[0]) . SEPARATOR . ($bottom + $change_right->[1]);    
            $graph->add_edge($next, $v_left);
            $graph->add_edge($next, $v_right);
            push @temp_next, $v_left, $v_right;
            push @temp_changes, $change_left;
            push @temp_changes, [$level + 1, 0], [0, $level + 1];
            push @temp_changes, $change_right;
        }while(@next && !$graph->has_vertex($member));
        @next = @temp_next;
        @changes = @temp_changes; 
        redo if !$graph->has_vertex($member);
    }
    return $graph;
}

sub curious_fraction_tree{
    my($member) = @_;
    my $graph = initialize($member);
    my($parent) = $graph->predecessors($member);
    my($grandparent) = $graph->predecessors($parent);
    return ($parent, $grandparent);
}

MAIN:{
    my($member, $parent, $grandparent);
    $member = "3/5";
    ($parent, $grandparent) = curious_fraction_tree($member);
    print "member = '$member'\n";
    print "parent = '$parent' and grandparent = '$grandparent'\n";
    print "\n";
    $member = "4/3";
    ($parent, $grandparent) = curious_fraction_tree($member);
    print "member = '$member'\n";
    print "parent = '$parent' and grandparent = '$grandparent'\n";
}