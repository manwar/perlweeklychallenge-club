#!/usr/bin/env raku

sub MAIN () {
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

}

sub find-squares(@matrix) {
    say "\n# Matrix";
    say .gist for @matrix;
    say "#=> squares -> " ~ (2 .. min(@matrix.elems, @matrix[0].elems)).map({ squares(@matrix, $_) }).sum;
}

sub squares(@matrix, $s) {
    my @corners = [
        [0,    0],
        [$s-1, 0],
        [0,    $s-1],
        [$s-1, $s-1],
    ];
    return ((0..@matrix.elems-$s) X (0..@matrix[0].elems-$s)).grep(
        -> @c {
            @corners.map({ $_ <<+>> @c }).map({ @matrix[ $_[0] ][ $_[1] ] }).all == 1
        }
    ).elems;
}
