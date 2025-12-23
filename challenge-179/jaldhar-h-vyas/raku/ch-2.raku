#!/usr/bin/raku

sub MAIN(
    *@n
) {
    my @bars = '▁' ... '█';
    my ($min,$max) = @n.minmax.bounds;

    for @n -> $n {
        print $n
            ?? @bars[ min(@bars * ($n - $min) / ($max - $min), @bars - 1) ]
            !! ' ';
    }
    print "\n";
}