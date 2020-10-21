sub count-flips(*@list) {
    my $max  := @list.sum div 2;
    my $list := @list>>.Int.sort.reverse.list;

    multi count-flips(:$pos where * == $list.elems, :$flips, :$acc) {
        $flips # End of list
    }

    multi count-flips(:$pos, :$flips, :$acc where * == $max) {
        $flips # Short-circuit, no need to process more
    }

    multi count-flips(:$pos, :$flips, :$acc) {
        count-flips # Process next element. Update acc and flips if applicable
            pos   => $pos.succ,
            flips => $acc + $list[$pos] <= $max ?? $flips.succ !! $flips,
            acc   => $acc + $list[$pos] <= $max ?? $acc + $list[$pos] !! $acc;
    }

    count-flips pos => 0, flips => 0, acc => 0;
}

if @*ARGS.elems > 0 {
    say count-flips @*ARGS>>.Int;
    exit 0;
}

use Test;

is count-flips(1), 0, 'One element';
is count-flips(1, 1), 1, 'Two equal elements';
is count-flips(2, 1), 1, 'Two different elements';
is count-flips(1, 2), 1, 'Two different elements - unsorted';
is count-flips(1, 2, 1), 1, 'turn middle element';
is count-flips(1, 2, 1, 4, 8), 1, 'turns one element (8)';
is count-flips(1, 2, 1, 4, 8, 1, 4, 3), 2, 'turns two elements (8, 4)';
is count-flips(2, 12, 15), 2, 'turns two element (12, 2)';
is count-flips(3, 12, 15), 1, 'turns one element (15)';
is count-flips(12, 0, 0, 0, 0, 12), 1, 'Equal elements with zeroes';
is count-flips(0, 1, 1, 2, 2, 2, 1, 1, 0), 3, 'Three flips';
is count-flips(0, 1, 1, 2, 2, 0 xx 1_000, 2, 1, 1), 3, 'Three flips with many zeros';
is count-flips(3, 10, 8), 1, 'Example 1';
is count-flips(12, 2, 10), 1, 'Example 2';

done-testing;
