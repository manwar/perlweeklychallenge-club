#!/usr/bin/raku

sub MAIN(
    *@arr
) {
    my $n = @arr.elems;
    my $index = 1;
    my $isTrionic = False;

    while $index < $n && @arr[$index] > @arr[$index - 1] {
        $index++;
    }

    my $peakIndex = $index - 1;

    if $peakIndex > 0 && $index < $n {
        while $index < $n && @arr[$index] < @arr[$index - 1] {
            $index++;
        }

        my $valleyIndex = $index - 1;

        if $valleyIndex > $peakIndex && $index < $n {
            while $index < $n && @arr[$index] > @arr[$index - 1] {
                $index++;
            }

            $isTrionic = $index == $n;
        }
    }

    say $isTrionic;
}
