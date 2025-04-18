#!/usr/bin/raku

sub MAIN(
    *@list
) {
    my @table = @list.map({ $_.comb.List });
    say @table[0]
        .keys
        .grep({ @table[*;$_].join ne @table[*;$_].sort.join })
        .elems;
}
