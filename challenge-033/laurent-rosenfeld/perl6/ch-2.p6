use v6;
sub MAIN (UInt $max = 11) {
    print-table($max);
}
sub print-table ($max) {
    # Print header
    printf "%2s |", "x";
    printf "%4d", $_ for 1..$max;
    say "\n---|", "-" x 4 * ($max);
    # Print table lines
    for 1..$max -> $i {
        printf "%2d |%s", $i, ' ' x 4 * ($i - 1);
        for $i..$max -> $j {
            printf "%4d", $i * $j;
        }
        say "";
    }
}
