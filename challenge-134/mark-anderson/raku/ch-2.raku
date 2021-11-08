#!/usr/bin/env raku

unit sub MAIN(UInt $r, UInt $c);

my @table;

@table[.head;.tail] = .head.succ * .tail.succ for ^$r X ^$c;

my @uniq = @table>>.Slip.flat.unique.sort;

my $fmt = ($r * $c).chars;

say .fmt("%{$fmt}d").substr($fmt - $r.chars) for @table;

say "\nDistinct Terms: ", @uniq.join(", "), "\nCount: ", +@uniq;
