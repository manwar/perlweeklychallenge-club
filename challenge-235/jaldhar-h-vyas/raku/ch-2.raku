#!/usr/bin/raku

sub MAIN(
    *@ints
) {
    my @output;

    for @ints -> $elem {
        if $elem == 0 {
            @output.push(| (0, 0));
        } else {
            @output.push($elem);
        }

        if @output.elems == @ints.elems {
            last;
        }
    }

    say q{(}, @output.join(q{, }, ), q{)};
}