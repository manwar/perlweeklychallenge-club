#!/usr/bin/raku

sub MAIN(
    $r,
    $c,
    *@ints
) {
    my @output;

    for 1 .. $r {
        @output.push(@ints.splice(0, $c));
    }

    say q{(}, @output.map({ q{[} ~ @$_.join(q{, }) ~ q{]} }).join(q{, }), q{)};
}