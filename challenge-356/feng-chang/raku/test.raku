#!/bin/env raku

# The Weekly Challenge 356
use Test;

sub pwc-test(Str:D $script, Bool :$deeply? = False, *@input) {
    my ($expect, $assertion) = @input.splice(*-2, 2);
    my $p = run $script, |@input, :out;
    if $deeply {
        is-deeply $p.out.slurp(:close).chomp.words.Bag, $expect, $assertion;
    } else {
        is $p.out.slurp(:close).chomp, $expect, $assertion;
    }
}

# Task 1, Kolakoski Sequence
pwc-test './ch-1.raku', 4, 2, 'Kolakoski Sequence: 4 => 2';
pwc-test './ch-1.raku', 5, 3, 'Kolakoski Sequence: 5 => 3';
pwc-test './ch-1.raku', 6, 3, 'Kolakoski Sequence: 6 => 3';
pwc-test './ch-1.raku', 7, 4, 'Kolakoski Sequence: 7 => 4';
pwc-test './ch-1.raku', 8, 4, 'Kolakoski Sequence: 8 => 4';

# Task 2, Who Wins
pwc-test './ch-2.raku', 'HAHAHH', 'Team 2 defeated Team 6', 'Who Wins: HAHAHH => "Team 2 defeated Team 6"';
pwc-test './ch-2.raku', 'HHHHHH', 'Team 1 defeated Team 2', 'Who Wins: HHHHHH => "Team 1 defeated Team 2"';
pwc-test './ch-2.raku', 'HHHAHA', 'Team 4 defeated Team 2', 'Who Wins: HHHAHA => "Team 4 defeated Team 2"';
pwc-test './ch-2.raku', 'HAHAAH', 'Team 4 defeated Team 6', 'Who Wins: HAHAAH => "Team 4 defeated Team 6"';
pwc-test './ch-2.raku', 'HAAHAA', 'Team 5 defeated Team 1', 'Who Wins: HAAHAA => "Team 5 defeated Team 1"';
