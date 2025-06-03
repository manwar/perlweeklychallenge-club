#!/usr/bin/raku

sub MAIN(
    Int $income,
    *@tax
) {
    my $taxed = 0;
    my %taxes = @tax.map({ [=>] $_.words });
    my $total = 0;

    for %taxes.keys.sort({$^a <=> $^b }) -> $bracket {
        if $taxed >= $income {
            last;
        }
 
        my $tax = ($bracket > $income ?? $income !! $bracket) - $taxed;
        $taxed += $tax;
        $total += $tax * (%taxes{$bracket} / 100);
    }

    say $total;
}