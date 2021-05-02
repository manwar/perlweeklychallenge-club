#!/usr/bin/raku

sub MAIN(
    *@n where { @n.elems == 7 } #= 7 integers
) {
    my @labels = 'a' .. 'g';
    for @n.permutations -> @permutation {
        my $box1 = @permutation[0] + @permutation[1];
        my $box2 = @permutation[1] + @permutation[2] + @permutation[3];
        my $box3 = @permutation[3] + @permutation[4] + @permutation[5];
        my $box4 = @permutation[5] + @permutation[6];

        if $box1 == $box2 == $box3 == $box4 {
            for 0 ..^ @permutation.elems -> $i {
                say @labels[$i],  ' = ', @permutation[$i];
            }
            print "\n"
        }
    }
}