#!/usr/bin/raku

sub MAIN(
    *@N where { @N.elems; } #= an array of integers
) {
    if @N.elems == 1 {
        say 0;
    } else {
        @N = @N.sort;
        my $previous = @N[0];
        my $largest = -∞;
        for 1 ..^ @N.elems -> $i {
            my $gap =  @N[$i] - $previous;
            if $gap > $largest {
                $largest = $gap;
            }
            $previous = @N[$i];
        }
        say $largest;
    }
}