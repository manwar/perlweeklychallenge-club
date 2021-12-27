#!/usr/bin/raku

sub work($arg) {
    sleep $arg / 100;
    say $arg;
}

sub MAIN(*@ARGS) {
    my @threads;
    for @*ARGS -> $arg {
        @threads.push( Thread.start( &{work($arg)} ) );
    }

    .finish for @threads;
}
