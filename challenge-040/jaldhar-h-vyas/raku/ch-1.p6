#!/usr/bin/perl6

multi sub MAIN() {
    my @array1 = < I L O V E Y O U >;
    my @array2 = < 2 4 0 3 2 0 1 9 >;
    my @array3 = < ! ? £ $ % ^ & * >;

    for [Z] @array1, @array2, @array3 -> @i {
        @i.join(q{ }).say;
    }
}