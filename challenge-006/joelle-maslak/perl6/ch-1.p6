#!/usr/bin/env perl6
use v6;

# To call this application:
#
# perl6 ch-1.p6 <numbers>
#
# Numbers should be space seperated.
#

my Pair $run;
my @runs;

for @*ARGS.sort( { $^a <=> $^b } ) -> Int() $num {
    if ! defined $run {
        $run = Pair.new($num, $num);
    } else {
        if $run.value == $num - 1 {
            $run = Pair.new($run.key, $num);
        } else {
            @runs.append($run);
            $run = Pair.new($num, $num);
        }
    }
    $run.freeze;
}
@runs.append($run) if defined $run;

say join(",", @runs.map( { (.key ≠ .value) ?? "{.key}-{.values}" !! .key } ) );
