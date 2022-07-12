#!/usr/bin/raku

sub MAIN() {
    my @sylvesters = (2, 3);

    while @sylvesters.elems < 10 {
        @sylvesters.push(([*] @sylvesters) + 1);
    }

    for @sylvesters {
        .say;
    }
}