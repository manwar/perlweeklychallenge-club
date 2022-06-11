#!/usr/bin/env perl6
#
#
#       factory-people-in-a-factory-world.raku
#
#
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN ( $n = 145 ) ;


my @f = map { [*] 1..$_ }, 0..9;    

sub is_factorion($n, $ds = 0) {
    $n == $n.comb
            .map({@f[$_]})
            .sum 
}

.say for (^10000000).grep: {is_factorion $_}

