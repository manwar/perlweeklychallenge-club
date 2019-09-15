#!/usr/bin/env perl

use v5.16;
use strict;
use warnings;

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

use Parallel::WorkUnit 2.181850;

my @NAMES = qw( audino bagon baltoy banette bidoof braviary bronzor carracosta
  charmeleon cresselia croagunk darmanitan deino emboar emolga exeggcute
  gabite girafarig gulpin haxorus heatmor heatran ivysaur jellicent
  jumpluff kangaskhan kricketune landorus ledyba loudred lumineon lunatone
  machamp magnezone mamoswine nosepass petilil pidgeotto pikachu pinsir
  poliwrath poochyena porygon2 porygonz registeel relicanth remoraid
  rufflet sableye scolipede scrafty seaking sealeo silcoon simisear
  snivy snorlax spoink starly tirtouga trapinch treecko tyrogue
  vigoroth vulpix wailord wartortle whismur wingull yamask
);
my %NEXTONES;

for my $name (@NAMES) {
    my $last_letter = substr( $name, -1 );
    $NEXTONES{$name} = [
        sort
        grep { $_ ne $name }
        grep { substr( $_, 0, 1 ) eq $last_letter } @NAMES
    ];
}

MAIN: {
    my (@longest) = build_longest();

    my $i = 1;
    for my $path (@longest) {
        say $i++ . " (" . scalar(@$path) . " elements): " . join ' ', $path->@*;
    }
}

sub build_longest() {
    my $wu = Parallel::WorkUnit->new();

    for my $name (@NAMES) {
        $wu->async( sub { return build_longest_helper($name) } );
    }
    my @results = $wu->waitall();

    my (@best_paths);

    for my $new_path (@results) {
        if ( ( scalar(@best_paths) == 0 )
            or scalar( $new_path->[0]->@* ) > scalar( $best_paths[0]->@* ) )
        {
            @best_paths = $new_path->@*;
        } elsif ( scalar( $new_path->[0]->@* ) == scalar( $best_paths[0]->@* ) ) {
            push @best_paths, $new_path->@*;
        }
    }

    return @best_paths;
}

sub build_longest_helper(@path) {
    my @best_paths;
    $best_paths[0] = \@path;

    my @next_possible = $NEXTONES{ $path[-1] }->@*;
    for my $name ( sort @next_possible ) {
        next if ( scalar( grep { $_ eq $name } @path ) );

        my @tmppath = @path;
        push @tmppath, $name;

        my $new_paths = build_longest_helper(@tmppath);

        if ( scalar( $new_paths->[0]->@* ) > scalar( $best_paths[0]->@* ) ) {
            @best_paths = $new_paths->@*;
        } elsif ( scalar( $new_paths->[0]->@* ) == scalar( $best_paths[0]->@* ) ) {
            push @best_paths, $new_paths->@*;
        }
    }

    return \@best_paths;
}

