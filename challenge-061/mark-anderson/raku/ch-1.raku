#!/usr/bin/env raku

#`(

Input: 
raku ch-1.raku 2 1 1 5 1 1 2

Output:
2 1 1 5
5 1 1 2
1 5 1 1 2
2 1 1 5 1
1 1 5 1 1 2
2 1 1 5 1 1

)

sub MAIN (*@array where @array.all ~~ Int) {
    my %hash;

    for (2 .. @array.end) -> $i {
        my @subs = @array.rotor($i => -($i-1));
        %hash{@subs} = @subs.map({[*] .Array});
    }

    .say for %hash.maxpairs.map(*.key).sort(+*.subst(q{ }, q{}, :g));
}
