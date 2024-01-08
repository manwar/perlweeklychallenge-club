#!/usr/bin/env raku

#| Run the Test Suite
multi sub MAIN('test') {
    use Test;
    is-deeply rot-matrix([[1,2],[3,4]]), [[1,3],[2,4]];
    is lucky( [[3,7,8],[9,11,13],[15,16,17]] ), 15;
    is lucky( [[1,10,4,2],[9,3,8,7],[15,16,17,12]] ), 12;
    is lucky( [[7,8],[1,2]] ), 7;
    is lucky( [[1,2],[3,4]] ), 3;
    done-testing;
}

multi sub MAIN(
    Int $width, #= Matrix width
    *@vals where @vals.unique.elems == @vals.elems #= Matrix values
                 && all(@vals) ~~ IntStr
                 && @vals.elems %% $width, 
) {
    my @matrix = @vals.rotor($width);
    lucky(@matrix).say;
}

sub rot-matrix( @matrix ) {
    my @out;
    for (^@matrix.elems) -> $i {
        for (^@matrix[0].elems) -> $j {
            @out[$j] //= [];
            @out[$j][$i] = @matrix[$i][$j];
        }
    }
    return @out;
}

sub lucky( @matrix ) {
    my @rot = rot-matrix(@matrix);
    my @mins = @matrix.map( *.min );
    my @maxs = @rot.map( *.max );
    my $int = @mins ∩ @maxs;
    return -1 unless $int.keys.elems == 1;
    return $int.keys[0];
}
