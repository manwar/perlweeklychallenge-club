#!/usr/bin/raku

sub MAIN(
    *@ints
) {
    my Bool $increasing = False;

    for 0 .. @ints.end -> $i {
        my @copy = @ints;
        @copy.splice($i, 1);

        if [<] @copy {
            $increasing = True;
            last;
        }
    }

    say $increasing;
}