#!/usr/bin/env raku
use Test;

ok  luhn's-algorithm("17893729974");
ok  luhn's-algorithm("4137 8947 1175 5904");
nok luhn's-algorithm("4137 8974 1175 5904");

sub luhn's-algorithm($str)
{
    my @ints = $str.comb(/<digit>/);

    my $payload = @ints.pop;

    @ints[@ints.end, @ints.end-2...0] .= map((* * 2).comb.sum); 

    (@ints.sum + $payload) %% 10
}
