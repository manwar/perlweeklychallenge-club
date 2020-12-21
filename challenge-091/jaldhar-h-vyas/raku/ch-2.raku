#!/usr/bin/raku

sub jump(@N) {
    my $current = 0;

    while $current < @N.elems - 1 {
        $current += @N[$current];
        if @N[$current] == 0 || $current >= @N.elems {
            return 0;
        }
    }

    return 1;
}


sub MAIN(
    *@N  #= a positive number.
) {
    say jump(@N);
}