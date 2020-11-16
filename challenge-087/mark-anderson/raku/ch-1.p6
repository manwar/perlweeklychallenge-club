multi MAIN(*@n where .all ~~ Int) {
    my @seqs = get-longest-seqs(@n);

    @seqs = @seqs.map(*.join(", ").List);

    .say for @seqs or 0;
}

multi MAIN {
    use Test;
    plan 3;

    cmp-ok get-longest-seqs([100, 4, 50, 3, 2]), 
           &[eqv], [(2, 3, 4),], "Example 1";

    cmp-ok get-longest-seqs([20, 30, 10, 40, 50]),
           &[eqv], [], "Example 2"; 
    
    cmp-ok get-longest-seqs([20, 19, 9, 11, 10]), 
           &[eqv], [(9, 10, 11),], "Example 3";
}

sub get-longest-seqs(@n) {
    my %h; 
    @n = @n.sort.unique;

    while @n {
        my $seq = @n.splice(0, get-index(@n));
        %h{$seq} = $seq.elems if $seq > 1;
    }

    sub get-index(@n) {
        for ^@n -> $i {
            unless @n[0..$i] == @n[0]..@n[$i] {
                return $i;
            }
        }

        return @n.elems;
    }

    [gather take .key.split(/\s/).map(+*).List for %h.maxpairs.sort];
}
