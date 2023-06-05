#! /usr/bin/raku

use Test;

plan 2;

is(travelexpenditure([2, 7, 25], [1, 5, 6, 7, 9, 15]), 11, 'example 1');
is(travelexpenditure([2, 7, 25], [1, 2, 3, 5, 7, 10, 11, 12, 14, 20, 30, 31]), 20, 'example 2');

sub travelexpenditure(@costs, @days0) {
    my @days = @days0.sort({$^a <=> $^b});
    my @validities = [1, 7, 30];
    my @stack;
    @stack.push({costdone => 0, daystodo => @days});
    my $cheapest = @days.elems * @costs[0];
    while (@stack.elems > 0) {
        my %c = @stack.shift;
        if (%c{'daystodo'}.elems == 0) {
            if (%c{'costdone'} < $cheapest) {
                $cheapest = %c{'costdone'};
            }
        } else {
            if (%c{'costdone'} >= $cheapest) {
                next;
            }
            my $start = %c{'daystodo'}[0];
            for 0..2 -> $i {
                my $ed = $start + @validities[$i] - 1;
                my @dtd = %c{'daystodo'}.grep({$_ > $ed});
                @stack.push({costdone => %c{'costdone'} + @costs[$i],
                                                        daystodo => @dtd});
            }
        }
    }
    return $cheapest;
}
