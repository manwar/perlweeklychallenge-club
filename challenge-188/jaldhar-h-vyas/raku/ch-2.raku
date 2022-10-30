#!/usr/bin/raku

sub MAIN(
    Int $x is copy, #= a positive integer
    Int $y is copy  #= a positive integer
) {
    my $operations = 0;

    repeat {
        my $prevX = $x;

        if $x >= $y {
            $x -= $y;
        }
        
        if $y >= $prevX {
            $y -= $prevX;
        }

        $operations++;

    } until $x == 0 && $y == 0;

    say $operations;
}