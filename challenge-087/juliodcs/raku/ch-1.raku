#! /usr/bin/raku

sub longest-sequence(*@N) {
    _longest((@N>>.Int).sort, 0, [], [])
}

sub _longest(@N, $i, @acc, @prev) {
    if ($i > @N.elems - 1) {
        my @longest = @acc.elems > @prev.elems ?? @acc !! @prev;
        return @longest.elems < 2 ?? 0 !! @longest
    }

    my $add-element := $i == 0 || @N[$i] == @N[$i.pred].succ;
    my $more-elems  := !$add-element && @acc.elems > @prev.elems;
    
    my @prev-new := $more-elems ?? @acc !! @prev;
    my @acc-new  := $add-element
        ?? (|@acc, @N[$i])
        !! $more-elems
            ?? List.new: @N[$i]
            !! @acc;

    _longest @N, $i.succ, @acc-new, @prev-new
}

if @*ARGS.elems > 0 {
    dd longest-sequence @*ARGS;
    exit 0
}

use Test;

is-deeply longest-sequence(1, 2, 7, 8, 9), [7, 8, 9], 'Tricky test: More elements at the end';
is-deeply longest-sequence(), 0, 'Empty list has no sequences';
is-deeply longest-sequence(4), 0, 'One element has no sequence';
is-deeply longest-sequence(4, 3), [3, 4], 'Two elements';
is-deeply longest-sequence(4, 3, 2, 1), [1, 2, 3, 4], 'All elements reversed';
is-deeply longest-sequence(4, 7, 2, 1), [1, 2], 'Two elements out of four';
is-deeply longest-sequence(4, 7, 2, 1, 5, 99, 6), [4, 5, 6, 7], 'Four elements';
is-deeply longest-sequence(100, 4, 50, 3, 2), [2, 3, 4], 'Test 1 from PWC';
is-deeply longest-sequence(20, 30, 10, 40, 50), 0, 'Test 2 from PWC';
is-deeply longest-sequence(20, 19, 9, 11, 10), [9, 10, 11], 'Test 3 from PWC';

done-testing;
