#!/usr/bin/perl6

multi sub MAIN(*@ARGS) {
    my @intervals;

    for @*ARGS -> $arg {
        $arg ~~ / \[ $<min> = (\d+) \, $<max> = (\d+) \] \,? /;
        @intervals.push($/<min> .. $/<max>);
    }
    my $size = @intervals.elems;
    my @merged;

    loop (my $i = 0; $i < $size - 1; $i++) {
        my $start = @intervals[$i].min();
        my $end = @intervals[$i].max();

        while $i < $size - 1 && $end ~~ @intervals[$i + 1] {
            $end = @intervals[$i + 1].max();
            $i++;
        }

        push @merged, $start .. $end;
    }

    @merged.map({ "[$_.min(),$_.max()]" }).join(', ').say;
}