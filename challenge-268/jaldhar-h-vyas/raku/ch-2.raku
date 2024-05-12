#!/usr/bin/raku

sub MAIN(
    *@ints
) {
    @ints = @ints.sort;
    my @output;

    while (@ints) {
        @output.push(| @ints.splice(0, 2).reverse);
    }

    say q{(}, @output.join(q{, }), q{)};
}