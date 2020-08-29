use v6;

my @a = @*ARGS.elems > 1 ?? @*ARGS !! (2, 1, 4, 5, 3, 7);
draw-histo(@a);
my ($area, @rectangle) = largest-rect(@a);
say "Largest rectangle is @rectangle[] with an area of $area.";


sub draw-histo (@in) {
    my $max-val = @in.max;
    say "  ", join "  ", 0..@in.end;
    say "  -" x @in.elems;
    for (1..$max-val).reverse -> $ordinate {
        print $ordinate;
        for 0..@in.end -> $i {
            print @in[$i] >= $ordinate ?? " # " !! "   ";
        }
        say "";
    }
    say "  =" x @in.elems;
    say "  ", join "  ", @in;
}

sub largest-rect (@in) {
    my $largest_area = 0;
    my @best-vals = 0, 0;
    for 0..^@in.end -> $i {
        for $i^..@in.end -> $j {
            my $area = ($j - $i + 1) * @in[$i..$j].min;
            # say "testing $i $j $area";
            if $area > $largest_area {
                $largest_area = $area;
                @best-vals = $i, $j;
            }
        }
    }
    return $largest_area, @best-vals;
}
