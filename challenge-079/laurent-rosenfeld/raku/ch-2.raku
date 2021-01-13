use v6;

my @a = @*ARGS.elems > 1 ?? @*ARGS !! (2, 1, 4, 1, 2, 5);
draw-histo(@a);
say "Rain capacity is: ", capacity(@a);


sub draw-histo (@in) {
    my $max-val = @in.max;
    say "";
    for (1..$max-val).reverse -> $ordinate {
        print $ordinate;
        for 0..@in.end -> $i {
            print @in[$i] >= $ordinate ?? " # " !! "   ";
        }
        say "";
    }
    say "  =" x @in.elems;
    say "  ", join "  ", @in, "\n";
}

sub capacity (@in) {
    my $left-max = @in[0];
    my $total = 0;
    for 1..@in.end-1 -> $i {
        $left-max = @in[$i] and next if @in[$i] > $left-max;
        my $right-max = max @in[$i+1..@in.end];
        my $col = min($left-max, $right-max) - @in[$i];
        $total += $col if $col > 0;
    }
    return $total
}
