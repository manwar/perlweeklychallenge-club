#!/usr/bin/env raku

sub find-squares(@matrix) {
    say "\n# Matrix";
    say .gist for @matrix;
    say "#=> squares -> " ~ squares(@matrix);
}

sub squares(@matrix) {
    return (2 .. min(@matrix.elems, @matrix[0].elems)).map(
        -> $s {
            ((0..@matrix.elems-$s) X (0..@matrix[0].elems-$s)).grep(
                -> @c {
                    1 == [[0,0], [$s-1,0], [0,$s-1], [$s-1, $s-1]]
                    .map({ $_ <<+>> @c })
                    .map({ @matrix[ $_[0] ][ $_[1] ] })
                    .all
                }
            ).elems
        }).sum;
}

#=> 1
find-squares [[ 0, 1, 0, 1 ],
              [ 0, 0, 1, 0 ],
              [ 1, 1, 0, 1 ],
              [ 1, 0, 0, 1 ]];

#=> 4
find-squares [[ 1, 1, 0, 1 ],
              [ 1, 1, 0, 0 ],
              [ 0, 1, 1, 1 ],
              [ 1, 0, 1, 1 ]];

#=> 0
find-squares [[ 0, 1, 0, 1 ],
              [ 1, 0, 1, 0 ],
              [ 0, 1, 0, 0 ],
              [ 1, 0, 0, 1 ]];

#=> 20
find-squares [[ 1, 1, 1, 1, 1 ],
              [ 1, 1, 1, 1, 1 ],
              [ 1, 1, 1, 1, 1 ],
              [ 1, 1, 1, 1, 1 ]];

#=> 20
find-squares [[ 1, 1, 1, 1 ],
              [ 1, 1, 1, 1 ],
              [ 1, 1, 1, 1 ],
              [ 1, 1, 1, 1 ],
              [ 1, 1, 1, 1 ]];

#=> 1
find-squares [[ 1, 0, 0, 1 ],
              [ 0, 0, 0, 0 ],
              [ 0, 0, 0, 0 ],
              [ 1, 0, 0, 1 ],
              [ 0, 0, 0, 0 ]];
