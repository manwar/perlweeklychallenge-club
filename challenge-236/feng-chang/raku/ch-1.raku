#!/bin/env raku

unit sub MAIN(*@bills);

my method can-pay(UInt:D $bill : %change --> Bool:D) {
    my $remain = $bill - 5;
    return False if $remain < 0;

    while $remain > 0 {
        my $bill_ = %change.keys.sort(-*).first(* ≤ $remain);
        return False without $bill_;

        --%change{$bill_};
        $remain -= $bill_;
    }

    ++%change{$bill};
    True
}

my %change is BagHash;
put so @bills».&can-pay(%change).all;
