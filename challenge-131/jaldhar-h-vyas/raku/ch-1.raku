#!/usr/bin/raku

sub MAIN(
    *@ints
) {
    my @results;
    @results.push([@ints[0]]);

    for 1 .. @ints.end -> $i {
        if @ints[$i] - @ints[$i - 1] != 1 {
            @results.push([]);
        }

        @(@results[*-1]).push(@ints[$i]);
    }

    say q{(}, @results.map({ q{[} ~ @$_.join(q{, }) ~ q{]} }).join(q{, }), q{)};
}