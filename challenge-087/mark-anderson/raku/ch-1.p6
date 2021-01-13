multi MAIN(*@n where .all ~~ Int) {
    my @seq = get-longest-seq(@n.map(+*).Array);

    say @seq ?? @seq.List.raku !! 0;
}

multi MAIN {
    use Test;
    plan 3;

    cmp-ok get-longest-seq([100, 4, 50, 3, 2]),   &[eqv], (2, 3, 4),   "Example 1";

    cmp-ok get-longest-seq([20, 30, 10, 40, 50]), &[eqv], [],          "Example 2";

    cmp-ok get-longest-seq([20, 19, 9, 11, 10]),  &[eqv], (9, 10, 11), "Example 3";
}

sub get-longest-seq(@n) {
    my %elems;
    my $from = 0;
    @n = @n.push(Inf).sort.unique;

    for ^@n.end -> $i {
        unless @n[$i] == @n[$i+1] - 1 {
            %elems{$from} = $i - $from;
            $from = $i + 1;
        }
    }

    my ($k, $v) = %elems.antipairs.max.kv;
    $k ?? @n[$v..$k+$v] !! [];
}
