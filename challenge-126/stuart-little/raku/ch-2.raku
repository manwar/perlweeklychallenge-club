#!/usr/bin/env raku
use v6;

# run <script>

sub nbrs(@mat, $i, $j) {
    return ((-1..1) X (-1..1)).map({ [$i+$_.[0], $j+$_.[1]] }).grep({ 0 <= $_.[0] < @mat.elems && 0 <= $_.[1] < @mat[0].elems && ($_.[0] != $i || $_.[1] != $j) }).Array
}
my @in = $=finish.lines.map({ $_.split(/\s+/).Array });

for ((0..^@in.elems) X (0..^@in[0].elems)) -> ($i, $j) {
    print( ((@in[$i][$j] eq 'x') ?? (@in[$i][$j]) !! (nbrs(@in,$i,$j).grep({ @in[$_[0]][$_[1]] eq 'x' }).elems))  ~ " " );
    ($j == @in[0].elems-1) && print("\n");
}

=finish
x * * * x * x x x x
* * * * * * * * * x
* * * * x * x * x *
* * * x x * * * * *
x * * * x * * * * x
