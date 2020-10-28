#!/usr/bin/perl6

sub MAIN(*@A) {
    my $min = ∞;
    my @result;

    for (0 ..^ @A.elems).combinations -> @combo {
        my @a = @A;

        for @combo -> $i {
            @a[$i] = -@a[$i];
        }

        my $total = [+] @a;

        if $total < $min && $total >= 0 {
            $min = $total;
            @result = @a;
        }
    }

    @result.grep({ $_ < 0; }).elems.say;
}