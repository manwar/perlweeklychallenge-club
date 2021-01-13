#!/usr/bin/env perl6
use v6;

my @gr=[
    < 1 2 3 >,
    < 4 5 6 >,
    < 7 8 9 >,
].map(*.map({ $_.Int })).map(*.Array);

sub cost(@gr,$i,$j) {
    $i==0 && return @gr[0][0..$j].sum;
    $j==0 && return @gr[0..$i].map(*.[0]).sum;
    return @gr[$i][$j]+min(cost(@gr,$i-1,$j),cost(@gr,$i,$j-1));
}

sub pth(@gr,@acc) {
    @acc+1 == @gr + @gr[0] && return @acc;
    given my ($x,$y) = @acc[0] {
	when ($x >= 1) && (@gr.&cost($x,$y)-@gr.&cost($x-1,$y)==@gr[$x][$y]) { pth(@gr,(($x-1,$y), |@acc)) }
	when ($y >= 1) && (@gr.&cost($x,$y)-@gr.&cost($x,$y-1)==@gr[$x][$y]) { pth(@gr,(($x,$y-1), |@acc)) }
    }
}

say cost(@gr, @gr.elems-1, @gr[0].elems-1), ": ", pth(@gr, ((@gr-1,@gr[0]-1),)).map({ @gr[$_[0]][$_[1]] }).join(" -> ")

# run as <script>
