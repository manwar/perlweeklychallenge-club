#!/usr/bin/perl
# The Weekly Challenge 115
# Task 1 String Chain
# Usage: ch-1.pl @S
use strict;
use warnings;

my @S = @ARGV;
@S = ("ade", "cbd", "fgh") if !@S;



if (consistent_degrees(@S) && is_connected(@S)) {
    print 1;
}
else {
    print 0;
}
print "\n";



sub consistent_degrees {
    my @edges = @_;
    my %i_vertex;
    my %o_vertex;
    for my $str (@edges) {
        my $head = substr $str, 0, 1;
        my $tail = substr $str, -1, 1;
        push $i_vertex{$tail}->@*, $head;
        push $o_vertex{$head}->@*, $tail;
    }

    for my $letter (keys %i_vertex) {
        if (!$o_vertex{$letter}) {
            return 0;
        }
        if (scalar @{$i_vertex{$letter}}
              != scalar @{$o_vertex{$letter}}) {
            return 0;
        }
    }
    return 1;
}


sub is_connected {
    my @edges = @_;
    my %collected;
    my %vertex_neigh;
    for my $str (@edges) {
        my $head = substr $str, 0, 1;
        my $tail = substr $str, -1, 1;
        $collected{$head} = -1;
        $collected{$tail} = -1;
        push $vertex_neigh{$head}->@*, $tail;
        push $vertex_neigh{$tail}->@*, $head;
    }
    # depth-first search
    my @stack = substr($edges[0], 0, 1);
    while (scalar @stack != 0) {
        my $cur = pop @stack;
        if ($collected{$cur} == 1) {
            next;
        }
        else {
            for my $neigh ($vertex_neigh{$cur}->@*) {
                push @stack, $neigh if $collected{$neigh} == -1;
            }
            $collected{$cur} = 1;
        }
    }
    #check connectedness
    for my $letter (keys %collected) {
        if ($collected{$letter} == -1) {
            return 0;
        }
    }
    return 1;
}
