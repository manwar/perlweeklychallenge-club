#!/usr/bin/raku

sub MAIN(
    *@ints
) {
    my $result = True;

    @ints.classify({ $_; }, :into( my %count) );

    for @ints.keys -> $n {
        if (%count{$n} // []).elems != @ints[$n] {
            $result = False;
            last;
        }
    }

    say $result;
}