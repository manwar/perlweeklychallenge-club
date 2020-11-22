use v6;

my @tests = [ 100, 4, 50, 3, 2 ],
            [ 20, 30, 10, 40, 50 ],
            [ 20, 19, 9, 11, 10 ];

for @tests -> @t {
    my @in = sort @t;
    my $last = @in[0];
    my @sequences;
    my $index = 0;
    push @sequences[$index], $last;
    for 1..@in.end -> $i {
        my $current = @in[$i];
        $index++ if $current != $last + 1;
        push @sequences[$index], $current;
        $last = $current;
    }
    my @sorted_seq = sort { $^b.elems <=> $^a.elems }, @sequence;
    if @sorted_seq[0] > 1 {
        say @sorted_seq[0];
    } else {
        say 0;
    }
}
