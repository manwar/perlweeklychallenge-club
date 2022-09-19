#!/usr/bin/env raku

sub iter-perm2rank ( Capture ( :@perm, :@seq=Empty  ) ) {
    my $h := @perm.head;
    \(
        :perm( |@perm.skip.map: {$_ - ($_ > $h)} ),
        :seq( $h, |@seq ),
    )
}

sub iter-rank2perm (Capture (:@seq, :@adepts,:@perm = Empty)) {
    my $h = @seq.head;
    \(
        :seq( @seq.skip ),
        :adepts( |@adepts.head($h), |@adepts.skip( $h+1 ) ),
        :perm( |@perm, @adepts[$h] ),
    )
}

sub permutation2rank (+@perm) {
    \( :@perm, ), &iter-perm2rank ... *.<perm>.elems == 0
    andthen .tail
    andthen .<seq>
    andthen .skip Z* [\*] 1..∞
    andthen .sum
}

sub rank2permutation ($rank, $n) {
    $rank
    andthen .polymod: 1..$n
    andthen \(:seq(.reverse.skip),:adepts(^$n) ), &iter-rank2perm ... *.<adepts>.elems == 0
    andthen .tail.<perm>
}

multi MAIN (Bool :test($)!) {
    use Test;
    is iter-rank2perm( \(:seq(1,1),:adepts(^3)) ).<adepts>, (0,2);
    is iter-perm2rank( \(:perm(1,2,0))  ).<perm>, (1,0);
    is permutation2rank(0,1,2,3,4),0;
    is rank2permutation(4,5), (0,1,4,2,3);
    for 1..5 {
        subtest {
            is permutation2rank(.value),.key, $_ for permutations(^$_).pairs;
        }, "perm2rank n=$_";
    }
    for 1..5 -> $n {
        subtest {
            is rank2permutation(.key, $n),.value, $_ for permutations(^$n).pairs;
        }, "perm2rank n=$n";
    }
    subtest {
        is permutation2rank(rank2permutation($_, 20)), $_ for  (1 .. [*] 1..20).roll(4)
    }, "perm2rank rank2perm n=20 (random)";

    done-testing;
}

multi MAIN ( $k,$n=10 ) {
    say  rank2permutation $k, $n
}
