#!/usr/bin/env perl

use feature qw{say} ;
use strict ;
use warnings ;

use Carp ;
use Data::Dumper ;
use Graph ;
use List::Util qw{min} ;
use Storable ;

my ( $first, $second ) = map { s/\W//gmix ; $_ }
    map { uc $_ } @ARGV ;
my $l = length $first ;

my $g = get_word_graph($l) ;
croak 'Words have different lengths' if length $first != length $second ;
croak "'$first' not in graph" unless $g->has_vertex($first);
croak "'$second' not in graph" unless $g->has_vertex($second);

my $r = dijkstra( $g, $first, $second ) ;
my @s = retrieve_solution( $r, $first, $second ) ;

say join ' > ', @s ;
say '' ;

exit ;

# -------------------------------------------------------------------
# context-specific perl implementation of Dijkstra's Algorithm for
# shortest-path
sub dijkstra {
    my ( $graph, $source, $target, ) = @_ ;
    my @q ;
    my %dist ;
    my %prev ;
    for my $v ( $graph->unique_vertices ) {
        $dist{$v} = 1_000_000_000 ;    # per Wikipeia, infinity
        push @q, $v ;
        }
    $dist{$source} = 0 ;
LOOP: while (@q) {
        @q = sort { $dist{$a} <=> $dist{$b} } @q ;
        my $u = shift @q ;

        # say STDERR join "\t", $u, $dist{$u} ;
        last LOOP if $u eq $target ;
        for my $e (
            grep {
                my @a = @$_ ;
                grep {/^${u}$/} @a
            } $graph->unique_edges
            ) {
            my ($v) = grep { $_ ne $u } @$e ;
            my $w   = 1 ;
            my $alt = $dist{$u} + $w ;
            if ( $alt < $dist{$v} ) {
                $dist{$v} = $alt ;
                $prev{$v} = $u ;
                }
            }
        }
    my @nodes = $graph->unique_vertices ;
    my @edges = $graph->unique_edges ;
    return {
        distances => \%dist,
        previous  => \%prev,
        nodes     => \@nodes,
        edges     => \@edges,
        } ;
    }

# -------------------------------------------------------------------
sub retrieve_solution {
    my $r     = shift ;
    my $start = shift ;
    my $end   = shift ;
    my %prev  = %{ $r->{previous} } ;

    my @words ;
    push @words, $end ;
    my $next = $end ;
    while ( $next ne $start ) {
        $next = $prev{$next} ;
        push @words, $next ;
        }
    return wantarray ? @words : \@words ;
    }

# -------------------------------------------------------------------
sub get_word_graph {
    my $length = shift ;
    # this is SLIGHTLY more localized
    my $file   = $ENV{HOME} ."/.word_$length.store" ;
    croak 'File not available' unless -f $file ;
    my $g = retrieve($file) ;
    return $g ;
    }

