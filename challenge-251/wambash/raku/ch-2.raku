#!/usr/bin/env raku

sub min-max (+matrix) {
    matrix
    andthen .map: *.min
    andthen .max
}

sub max-min (+matrix) {
    matrix
    andthen [Zmax] $_
    andthen .min
}

sub lucky-number (+@matrix) {
    my $mm = min-max( @matrix);
    $mm == max-min(@matrix) ?? $mm !! -1
}

multi MAIN (Bool :test($)!) {
    use Test;
    subtest 'matrix 3x3' ,{
        my @matrix := (
             3, 7, 8;
             9,11,13;
            15,16,17;
        );
        is min-max(@matrix),     15;
        is max-min(@matrix),     15;
        is lucky-number(@matrix),15;
    }
    subtest 'matrix 3x4' ,{
        my @matrix := (
            1, 10,  4,  2;
            9,  3,  8,  7;
           15, 16, 17, 12;
        );
        is min-max(@matrix),     12;
        is max-min(@matrix),     12;
        is lucky-number(@matrix),12;
    }
    subtest 'matrix 2x2' ,{
        my @matrix := (
            7, 8;
            1, 2;
        );
        is min-max(@matrix),     7;
        is max-min(@matrix),     7;
        is lucky-number(@matrix),7;
    }
    subtest 'matrix 2x2 without lucky number' ,{
        my @matrix := (
            7, 2;
            1, 4;
        );
        is min-max(@matrix),     2;
        is max-min(@matrix),     4;
        is lucky-number(@matrix),-1;
    }
    done-testing;
}

multi MAIN (+matrix) {
    say lucky-number matrix.map: *.split(',').cache
}
