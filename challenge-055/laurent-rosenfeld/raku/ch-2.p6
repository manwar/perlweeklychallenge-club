use v6;

my SetHash $results;

sub add_1_item ($mode, @input, @output) {
    unless @input.elems {
        $results{"@output[]"}++;
        return;
    }

    my $last = @output[*-1];
    for 0..@input.end -> $i {
        if ($mode == 0) {
            next if @input[$i] > $last;
            add_1_item(1, @input[0..$i-1, $i+1..@input.end].flat,
                (@output, @input[$i]).flat);

        } else {
            next if @input[$i] < $last;
            add_1_item(0, @input[0..$i-1, $i+1..@input.end].flat,
                (@output, @input[$i]).flat);
        }
    }
}

my @in = 1, 2, 3, 4;
@in = @*ARGS if @*ARGS.elems > 0;
for 0..@in.end -> $i {
    my @out = @in[$i],;
    add_1_item(0, @in[0..$i-1, $i+1..@in.end].flat, @out);
}
.say for $results.keys.sort;
