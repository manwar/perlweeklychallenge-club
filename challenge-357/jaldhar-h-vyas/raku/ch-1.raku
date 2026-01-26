#!/usr/bin/raku

sub MAIN(
    $int is copy
) {
    constant KAPREKAR = 6174;

    my $count = 0;

    while $int != KAPREKAR {
        if $int == 0 {
            $count = -1;
            last;
        }
        my $smaller = sprintf("%04d", $int.comb.sort.join);
        my $larger = $smaller.flip;
        $int = $larger - $smaller;
        $count++;
    }

    say $count;
}
