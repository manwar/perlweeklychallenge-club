#!/usr/bin/env raku

sub ulam-next (+@u) {
    @u
    andthen .tail ^.. *
    andthen .first: {
        $_ == @u.combinations(2).map(*.sum).one
    }
}

sub ulam-seq (+@u) {
    @u
    andthen |$_, &ulam-next ... *
}

multi MAIN (Bool :test($)!) {
    use Test;
    is ulam-next(1,2,3,4),6;
    is ulam-next(1,2,3,4,6,8),11;
    is ulam-seq(1,2).head(10),(1, 2, 3, 4, 6, 8, 11, 13, 16, 18);
    is ulam-seq(2,3).head(10),(2, 3, 5, 7, 8, 9, 13, 14, 18, 19);
    is ulam-seq(2,5).head(10),(2, 5, 7, 9, 11, 12, 13, 15, 19, 23);
    done-testing;
}

multi MAIN (*@u, :$n=10) {
    put ulam-seq(@u).head: $n
}
