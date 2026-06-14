#!/usr/bin/raku

sub MAIN(
    *@array
) {
    my $count = 0;

    for 0 ..^ @array.end -> $i {
        for $i + 1 .. @array.end -> $j {
            if @array[$j].starts-with(@array[$i]) && @array[$j].ends-with(@array[$i]) {
                $count++;
            }
        }
    }

    say $count;
}
