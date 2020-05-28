#!/usr/bin/env raku

# 1. n-queens-d3 finds the solution using beam search
# 2. the higher the beamr-width, the better is the solution. 
# 3. with beam-width=1, it's very fast but the solution may not be optimal maximising the number of queens.
# 4. with beam-width=-1, it searches the entire search space. Ensures best solution but slow as hell for high n
# 5. I think one can find the best solution with beam-width 2-3 for n-values less than 8

sub n-queens-d3($n = 2, $beam-width=2) {
        my @solutions = [];
        place-queen [^$n X ^$n X ^$n], [], @solutions, $beam-width;
        my $best = @solutions.max(+*);
        say "Queens placed : ", +$best;
        return indices-to-array $best, $n;
}


sub place-queen(@indices, @queens, @solutions, $beam-width=2) {
       if not @indices {
               @solutions.push(@queens);
               return;
       }
       my @best = (for @indices -> $pos {($pos, @indices.grep({is-available($pos, $_)}))});
       if $beam-width ≠ -1 {
               @best = find-best($beam-width, @best, {+$^b[1] cmp +$^a[1]}); 
       }
       for @best -> ($pos, @available) {
               place-queen(@available, (|@queens, $pos), @solutions, $beam-width);
       }
}


sub is-available($ref, $pos) {
        my $diff = ($ref »-« $pos)».abs.Set;
        not (+$diff == 1 || (+$diff == 2 && 0 ∈ $diff))
}


sub indices-to-array(@indices, $n) {
    my @array = [[[ 0 xx $n] xx $n] xx $n];
    for @indices -> ($x, $y, $z) {
            @array[$x; $y; $z] = 1;
    }
    return @array;
}


#| ideally this routine should use a priority queue for better efficiency
sub find-best($n, @elems, &key){
        my @sorted = @elems.sort(&key);
        return @sorted[^$n] if +@sorted > $n;
        return @sorted;
}


sub MAIN (Int :$n=2, Int :$beam=2) {
        say n-queens-d3 $n, $beam;
}
