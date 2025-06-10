#!/usr/bin/raku

sub MAIN(
    *@prices
) {
    my @result;

    for 0 ..^ @prices.elems -> $i {
        my $discount = 0;
        for $i + 1 ..^ @prices.elems -> $j {
            if @prices[$j] <= @prices[$i] {
                $discount = @prices[$j];
                last;
            }
        }
        @result.push(@prices[$i] - $discount);
    }

    say q{(}, @result.join(q{, }), q{)};
}