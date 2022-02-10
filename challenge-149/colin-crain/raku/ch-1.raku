#!/usr/bin/env perl6
#
#
#       fib-sums.raku
#
#
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN ( $N = 25 ) ;

sub is_fib ( $num ) {
    state @fibs = (0, 1, 1, * + * ... *);
    state %fh;
    state $n = 0;
    while @fibs[$n] < $num  {
        %fh{ @fibs[++$n] } = 1; 
    }

    return %fh{$num}:exists
        ?? 1
        !! 0
}

my  @out = (0, | grep { is_fib( $_.comb.sum ) }, (0..*) )[0..$N-1];
say @out;

