#!/usr/bin/raku

sub MAIN(
    *@ints
) {
    my @hamming = @ints.map({ $_.base(2).comb.List });

    my $length = @hamming».elems.max;
    @hamming = @hamming.map({
        my @padded = @$_;
        while @padded.elems < $length {
            @padded.unshift('0');
        }

        @padded;
    });

    my $total = 0;

    for @hamming.combinations(2) -> [$a, $b] {
        $total += (@$a Zne @$b).grep({ $_ == True }).elems;
    }

    say $total;
}
