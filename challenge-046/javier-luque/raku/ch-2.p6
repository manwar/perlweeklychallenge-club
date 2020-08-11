# Test: perl6 ch-2.p6
use v6.d;

sub MAIN () {
    my @doors;
    @doors[0 .. 500] = 0;

    for (1 .. 500) -> $employee {
        for ($employee .. 500 ) -> $door {
            next unless $door % $employee == 0;
            @doors[$door] = (@doors[$door]) ?? 0 !! 1;
        }
    }

    for (1 .. 500) -> $i {
        say "Door: " ~ $i ~ " is open."
            if (@doors[$i]);
    }
}
