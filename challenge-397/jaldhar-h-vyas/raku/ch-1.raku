#!/usr/bin/raku

sub MAIN(
    *@arr
) {
    @arr = @arr».Int;
    my $average = @arr.sum / @arr.elems;
    my $start = ($average.Int + 1); 
    if $start < 1 {
        $start = 1;
    }

    for $start .. ∞ -> $num {
        if $num ∉ @arr {
            say $num;
            last;
        }
    }
}
