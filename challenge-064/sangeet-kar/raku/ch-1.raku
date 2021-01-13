#!/usr/bin/env raku

use Tuple;

class Node {
        has $.pos;
        has $.path;
        has $.cost;
        has $.visited;
}

sub manhattan-dist ($pos, $goal) { ($goal »-« $pos).sum }

sub next-states ($pos, $matrix) {
        (((1, 0), (0, 1), (-1, 0), (0, -1)) »+» ($pos,)).grep({(0 ≤ $_[0] < 0+$matrix) && (0 ≤ $_[1] < 0+$matrix[0])}).map({tuple($_)})
}

sub move($curr-node, $pos, $matrix) {
        my $cost = $matrix[$pos[0]][$pos[1]];
        Node.new(pos => $pos, path => (|$curr-node.path, $cost), cost => $cost + $curr-node.cost, visited => $curr-node.visited ∪ set($pos));
}

sub solve($matrix) {
        my $init = tuple((0, 0));
        my $goal = tuple(($matrix-1, $matrix[0]-1));

        my $curr-cost = $matrix[$init[0]][$init[1]];
        my @states = (Node.new(pos => $init, path => ($curr-cost,), cost => $curr-cost, visited => set($init)), );
        
        while @states {
                my $best-node = @states.min({$_.cost + manhattan-dist $_.pos, $goal});
                if $best-node.pos eqv $goal {
                        say $best-node.cost, " : ", $best-node.path.join(" → ");
                        last;
                }
                @states .= grep({not $_ eqv $best-node});
                for next-states($best-node.pos, $matrix) -> $state {
                       my $next-node = move($best-node, $state, $matrix);
                       @states.push($next-node) if $next-node.pos ∉ $best-node.visited;
               }
        }
}


my $matrix = (1..9).rotor(3);
solve($matrix);

#A more complex matrix with negative cost
$matrix = ((1,  2, 3),
           (12, 2, 6),
           (-3, 6, 20),
           (2,  8, 9));
solve($matrix);
