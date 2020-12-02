#!/usr/bin/env perl6
use v6;

shell("clear");

loop {
    say "Hit Ctrl+C to exit\n";
    say DateTime.now.hh-mm-ss;
    sleep(1);    
    shell("clear");
    signal(SIGINT).tap( { say "Bye!"; exit 0 } );
}

# run as <script>
