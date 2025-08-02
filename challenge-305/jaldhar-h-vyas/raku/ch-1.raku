#!/usr/bin/raku

sub MAIN(
    *@binary
) {
    my @results;

    for 0 .. @binary.end -> $i {
        @results.push(@binary[0 .. $i].join.parse-base(2).is-prime);
    }

    @results.join(q{ }).say;

}
