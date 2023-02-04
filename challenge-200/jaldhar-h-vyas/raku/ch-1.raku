#!/usr/bin/raku

sub MAIN(
    *@array
) {
    my @results = ();
    @array = @array.sort({ $^a <=> $^b });

    for 0 .. @array.end - 2 -> $i {
        slice: for $i + 2 .. @array.end -> $j {
            my @slice = @array[$i .. $j];
            my $diff = @slice[1] - @slice[0];
            for 2 .. @slice.end -> $k {
                if @slice[$k] - @slice[$k - 1] != $diff {
                    last slice;
                }
            }
            @results.push(@slice);
        }
    }

    say q{(},
        @results.sort({ $^a.elems <=> $^b.elems }).map({ @$_.join(q{, }) })
        .join(q{), (}),
        q{)};
}
