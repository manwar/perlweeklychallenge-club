#!/usr/bin/env raku

sub tax-amount-redu (($income, $acc=0), ($upto, $tax)) {
    my $tax-base = $income min $upto;
    ($income - $tax-base, $acc + $tax-base*$tax/100 )
}

sub tax-amount (+tax,:$income) {
     my @tax-diff = tax.produce: -> ($aupto, $atax), ($upto,$tax) { ($upto-$aupto, $tax) };

    ($income,0), |@tax-diff
    andthen .reduce: &tax-amount-redu
    andthen .tail
}

multi MAIN (Bool :test($)!) {
    use Test;
    is tax-amount((3,50),(7,10),(12,25)):10income, 2.65;
    is tax-amount((1,0),(4,25),(5,50)):2income, 0.25;
    is tax-amount(((2,50),)):0income, 0;
    done-testing;
}

multi MAIN (+tax, :$income) {
    say tax-amount tax.batch(2), :$income;
}
