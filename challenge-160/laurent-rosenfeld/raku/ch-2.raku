sub equilibrium (@ary) {
    for 1..@ary.end-1 -> $i {
        return $i if @ary[0..$i-1].sum == @ary[$i+1..@ary.end].sum;
    }
    return -1;
}
for <1 3 5 7 9>, <1 2 3 4 5>, <2 4 2> -> @a {
    say "@a[]".fmt("%-12s"), " -> ", equilibrium(@a);
}
