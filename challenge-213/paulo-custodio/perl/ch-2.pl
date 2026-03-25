#!/usr/bin/env perl

# Perl Weekly Challenge 213 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-213/

use Modern::Perl;

# https://pt.wikipedia.org/wiki/Algoritmo_de_Dijkstra
{
    package Graph;
    use constant Inf => 1e10;

    sub new {
        my($class) = @_;
        return bless { adj => [], dist => [], seen => [], path => [] }, $class;
    }

    sub adj {
        my ($self, $value) = @_;
        $self->{adj} = $value if @_ == 2;   # setter
        return $self->{adj};                # getter
    }

    sub dist {
        my ($self, $value) = @_;
        $self->{dist} = $value if @_ == 2;
        return $self->{dist};
    }

    sub seen {
        my ($self, $value) = @_;
        $self->{seen} = $value if @_ == 2;
        return $self->{seen};
    }

    sub path {
        my ($self, $value) = @_;
        $self->{path} = $value if @_ == 2;
        return $self->{path};
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
say "(", join(", ", $graph->dijkstra($start, $finish)), ")";
