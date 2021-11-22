#!/usr/bin/env raku

say kth-element-from-sorted-multiplication-table(2, 3, 4);
say kth-element-from-sorted-multiplication-table(3, 3, 6);

sub kth-element-from-sorted-multiplication-table(\i, \j, \k)
{
    my @table;
    @table[.head; .tail] = .head.succ * .tail.succ for ^i X ^j;
    @table.map(|*).sort.[k-1];
}
