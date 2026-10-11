#!/usr/bin/perl

#use v5.26;
use strict;
use warnings;
use autodie;
use constant MODEL => 'longest_path.mod';
use constant DATA => 'graph.dat';
use constant SOLUTION => 'solution.txt';


### Input and Output

print "\nSolution:\n@{[pokemon_names(@ARGV ? @ARGV :
    qw(audino bagon baltoy banette bidoof braviary bronzor carracosta charmeleon cresselia croagunk darmanitan deino emboar emolga exeggcute gabite girafarig gulpin haxorus heatmor heatran ivysaur jellicent jumpluff kangaskhan kricketune landorus ledyba loudred lumineon lunatone machamp magnezone mamoswine nosepass petilil pidgeotto pikachu pinsir poliwrath poochyena porygon2 porygonz registeel relicanth remoraid rufflet sableye scolipede scrafty seaking sealeo silcoon simisear snivy snorlax spoink starly tirtouga trapinch treecko tyrogue vigoroth vulpix wailord wartortle whismur wingull yamask))]}\n";


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/10/12/ch-025.html#task-1

sub pokemon_names {
    -f MODEL || die "model '" . MODEL . "' not found";
    open my $data, '>', DATA;
    printf $data "param n := %d;\n", scalar @_;
    print $data "set E :=\n";
    for my $v1 (0 .. $#_) {
        for my $v2 (0 .. $#_) {
            printf $data "(%d,%d)\n", $v1, $v2
                if substr($_[$v1], -1) eq substr($_[$v2], 0, 1);
        }
    }
    print $data ";\n";
    print $data "end;\n";
    close $data;

    system "glpsol --model " . MODEL .
        " --data " . DATA . " --output " . SOLUTION;

    open my $sol, '<', SOLUTION;
    my $solution = do {local $/; <$sol>};
    close $sol;

    $solution =~ /^ *\d+ +s\[(\d+)\] +\* +1 /m;
    my $i = $1;
    my @words;
    push @words, $_[$i];
    while ($solution =~ /^ *\d+ +y\[$i,(\d+)\] +\* +1 /m) {
        $i = $1;
        push @words, $_[$i];
    }

    @words;
}
