#!/usr/bin/raku

sub MAIN(
    *@matrix is copy
) {
    @matrix = @matrix.map({ [ .words ] });
    my $n = @matrix[0].elems;
    my @ints = 1 .. $n;
    my $isSame = True;

    for 0 ..^ $n -> $side {
        if (@matrix[$side].sort({ $^a <=> $^b }) Z== @ints).any == False ||
        (@matrix[0 ..^ $n;$side].sort({ $^a <=> $^b }) Z== @ints).any == False {
            $isSame = False;
            last;
        }
    }

    say $isSame;
}
