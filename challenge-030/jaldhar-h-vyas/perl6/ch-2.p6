#!/usr/bin/perl6

sub MAIN() {
    my %results;

    for (1 .. 10) -> $i {
        for (1 .. (12 - $i - 1)) -> $j {
            my $k = 12 - $i - $j;
            %results{($i, $j, $k).sort.join(q{ })}++;
        }
    }

    .say for %results.keys.sort;
}