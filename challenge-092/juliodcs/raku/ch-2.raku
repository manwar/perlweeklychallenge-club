#! /usr/bin/env raku

sub add-new(@s, $n) {
    sort |@s, $n
}

sub merge($range1, $range2) {
    $range1.list ∩ $range2
        ?? min($range1.head, $range2.head) .. max($range1.tail, $range2.tail)
        !! $range1
}

sub re-merge(@ranges) {
    @ranges.rotor(2 => -1).map({ [∩] $_ }).grep(*.elems > 0).elems > 0
        ?? re-merge @ranges.rotor(2 => -1).map({ merge .head, .tail })
        !! @ranges
}

my @s = (1 .. 2, 3 .. 7, 8 .. 10);
my $n = 5 .. 8;

say re-merge add-new @s, $n;
