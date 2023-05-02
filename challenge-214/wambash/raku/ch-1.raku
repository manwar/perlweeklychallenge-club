#!/usr/bin/env raku
enum M (<G S B>);

multi rank-place (M(Int) $_){ $_ }
multi rank-place (Int $_ where * > 2){ $_ + 1 }
multi rank-place (+@place) { @place.map: &rank-place }

sub rank-score (+@score) {
    my %rank := @score.sort.reverse.antipairs.squish( as => *.key ).hash;

    @score.map: { rank-place %rank{$_} }
}

multi MAIN (Bool :test($)!) {
    use Test;
    is rank-place(0,1,3,2,4),(G,S,4,B,5);
    is rank-score(1,2,4,3,5),(5,4,S,B,G);
    is rank-score(8,5,6,7,4),(G,4,B,S,5);
    is rank-score(3,5,4,2)  ,(B,G,S,4);
    is rank-score(2,5,2,1,7,5,1),(4,S,4,6,G,S,6);
    done-testing;
}

multi MAIN (*@score) {
    say rank-score @score;
}
