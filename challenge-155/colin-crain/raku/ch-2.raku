#!/usr/bin/env perl6
#
#
#       pisa-party.raku
#
#
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN ($fibs = 256) ;

my @fs = ( 0, 1, * + * ... * )[^$fibs];
my @pisas = gather {
    for 2..35 -> $mod {
        $_ = @fs.map({$_ % $mod}) 
                .map({ (|(0..9), |('A'..'Z'))[$_] }) 
                .join ;
        /(0.+?){}$0/ ;
        take $0.chars;
    }
}


for @pisas.kv -> $p, $q {
    say ($p+2, $q).fmt("%3d", ' → ');
}

