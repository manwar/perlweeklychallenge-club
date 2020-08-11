#!/usr/bin/env perl6

# ch-2.raku - +1 or *2 to 200
#
# Ryan Thompson <rjt@cpan.org>

say double-or-plus(1, 200);

# Shortest path verified past 1..43000, maybe I'll come up with a proof
sub double-or-plus( Int $start, Int $end is copy ) {
    my @path = $end;
    while ($end != $start) {
        $end = $end %% 2 ?? ($end / 2).Int !! $end -1;
        @path.unshift($end);
    }

    @path;
}
