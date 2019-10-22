#!/usr/bin/env perl6

use v6;

#| Display Help Text
multi sub MAIN( Bool :h(:$help) where so * ) {
    say $*USAGE;
}

#| Print an updating clock on the command line
multi sub MAIN() {
    END say "";
    loop {
        print "{DateTime.now.hh-mm-ss}";
        sleep 1;
        print "\r";
    }
}
