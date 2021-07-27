#!/usr/bin/raku

sub arrangement(Int $ones, Int $twos, Int $threes) {
    my @arranged;

    if $ones {
        @arranged.push(| ('1' xx $ones));
    }

    if $twos {
        @arranged.push(| ('2' xx $twos));
    }

    if $threes {
        @arranged.push(| ('3' xx $threes));
    }

    return @arranged;
}

sub MAIN(
    Int $S #= score
) {
    my %scores;

    for  0 .. $S div 3 -> $threes {
        my $remainder = $S - $threes * 3;
        for 0 ..  $remainder div 2 -> $twos {
            my $ones = $remainder - $twos * 2;
            for arrangement($ones, $twos, $threes).permutations -> $perm {
                %scores{$perm}++;
            }
        }
    }

    for %scores.keys.sort -> $score {
        say $score;
    }
}
