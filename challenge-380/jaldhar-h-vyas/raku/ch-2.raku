#!/usr/bin/raku

sub MAIN(
    $str
) {
    my %reverse = 'a' .. 'z' Z=> (1 .. 26).reverse;
    my $result = 0;

    for $str.comb.kv -> $pos, $char {
        $result += ($pos + 1) * %reverse{$char};
    }

    say $result;
}
