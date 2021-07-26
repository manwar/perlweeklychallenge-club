#!/usr/bin/raku

sub MAIN(*@ARGS) {
    my $total = 0;
    my $count = 1;
    my @averages;

    for  @ARGS -> $arg {
        $total += $arg;
        @averages.push($total / $count++);
    }

    @averages.join(q{ }).say;
}
