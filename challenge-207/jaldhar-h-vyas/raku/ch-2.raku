#!/usr/bin/raku

sub MAIN(
    *@citations
) {
    my $hindex = 0;

    for 1 .. @citations.elems -> $h {
        if @citations[$h - 1] < $h {
            last;
        }
        $hindex = $h;
    }

    say $hindex;
}
