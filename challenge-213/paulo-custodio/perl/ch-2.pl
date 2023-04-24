#!/usr/bin/perl

# Challenge 213
#
# Task 2: Shortest Route
# Submitted by: Mohammad S Anwar
#
# You are given a list of bidirectional routes defining a network of nodes,
# as well as source and destination node numbers.
#
# Write a script to find the route from source to destination that passes
# through fewest nodes.
# Example 1:
#
# Input: @routes = ([1,2,6], [5,6,7])
#        $source = 1
#        $destination = 7
#
# Output: (1,2,6,7)
#
# Source (1) is part of route [1,2,6] so the journey looks like 1 -> 2 -> 6
# then jump to route [5,6,7] and takes the route 6 -> 7.
# So the final route is (1,2,6,7)
#
# Example 2:
#
# Input: @routes = ([1,2,3], [4,5,6])
#        $source = 2
#        $destination = 5
#
# Output: -1
#
# Example 3:
#
# Input: @routes = ([1,2,3], [4,5,6], [3,8,9], [7,8])
#        $source = 1
#        $destination = 7
# Output: (1,2,3,8,7)
#
# Source (1) is part of route [1,2,3] so the journey looks like 1 -> 2 -> 3
# then jump to route [3,8,9] and takes the route 3 -> 8
# then jump to route [7,8] and takes the route 8 -> 7
# So the final route is (1,2,3,8,7)

use Modern::Perl;

# https://pt.wikipedia.org/wiki/Algoritmo_de_Dijkstra
{
    package Graph;
    use Object::Tiny::RW qw{ adj dist seen path };
    use constant Inf => 1e10;

    sub new {
        my($class) = @_;
        return bless { adj => [], dist => [], seen => [], path => [] }, $class;
    }

    sub add_segment {
        my($self, $v1, $v2, $cost) = @_;
        $self->adj->[$v1] ||= [];
        push @{$self->adj->[$v1]}, [$cost, $v2];
    }

    sub dijkstra {
        my($self, $orig, $dest) = @_;
        $self->dist([]);
        $self->seen([]);
        my @q;
        for my $i (0 .. $#{$self->adj}) {
            $self->dist->[$i] = Inf;
            $self->seen->[$i] = 0;
        }
        $self->dist->[$orig] = 0;
        push @q, [$self->dist->[$orig], $orig, []];
        $self->path([]);
        while (@q) {
            @q = sort {$a->[0]<=>$b->[0]} @q;
            my($dummy, $u, $path) = @{shift @q};
            if (!$self->seen->[$u]) {
                $self->seen->[$u] = 1;
                for (@{$self->adj->[$u]}) {
                    my($cost, $v) = @$_;
                    if ($self->dist->[$v] > $self->dist->[$u] + $cost) {
                        $self->dist->[$v] = $self->dist->[$u] + $cost;
                        push @q, [$self->dist->[$v], $v, [@$path, $u]];
                        $self->path([@$path, $u]);
                    }
                }
            }
        }
        push @{$self->path}, $dest;
        return @{$self->path};
        # distance return $self->dist->[$dest];
    }
}

sub parse_input {
    my(@args) = @_;
    my $graph = Graph->new;
    my @start_finish;
    for (@args) {
        if (/,/) {
            my @steps = split /,/, $_;
            for my $i (0 .. $#steps-1) {
                $graph->add_segment($steps[$i], $steps[$i+1], 1);
                $graph->add_segment($steps[$i+1], $steps[$i], 1);
            }
        }
        else {
            push @start_finish, $_;
        }
    }
    return ($graph, @start_finish);
}

my($graph, $start, $finish) = parse_input(@ARGV);
say join ",", $graph->dijkstra($start, $finish);
