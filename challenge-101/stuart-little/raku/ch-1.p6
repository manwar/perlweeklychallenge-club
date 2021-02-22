#!/usr/bin/env perl6
use v6;

# run <script> <space-separated array entries>

sub rtcc(@m) {
    (0..^@m.[0].elems).map({ @m.map(*.[$_]).Array }).reverse.Array
}

sub pck($rows,$cols,@a) {
    $rows == 1 && return [@a,];
    $cols == 1 && return @a.reverse.map({ [$_,] }).Array;
    my @rot = rtcc(pck($cols,$rows-1,@a[$cols..*]));
    return [|@rot,@a[0..$cols-1]];
}

my $els = @*ARGS.elems;
my $rows = [1..(@*ARGS.elems div 2)].grep({ $els %% $_ }).min({ ($_ - ($els div $_)).abs });
my $cols = $els div $rows;

for (pck($rows,$cols,@*ARGS.map({ sprintf("%5s",$_) }))) {
    say "$_";
}
