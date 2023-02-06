#!/usr/bin/raku

sub MAIN(
    *@args
) {
    my @vallies;

    for 0 .. @args.end -> $i {
        my @valley;
        my Bool $ascending = False;

        for $i .. @args.end -> $j {
            if $ascending && @valley.elems && @args[$j] < @valley[*-1] {
                $ascending = False;
                last;
            } elsif !$ascending && @valley.elems && @args[$j] > @valley[*-1] {
                $ascending = True;
            }
            @valley.push(@args[$j]);
        }
        @vallies.push(@valley);
    }

    @vallies.sort({ @$^b.elems <=> @$^a.elems })[0].join(q{, }).say;
}