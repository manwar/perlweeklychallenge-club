#!/usr/bin/env raku
# vim: ft=raku sw=4 expandtabs
use v6.d;

my %tag = (1 … 500) Z=> ( (False) xx 500);

my @prime =  2, 3,  5,  7,  11,  13,  17,  19, ;
my @square = @prime»² ;

for 4 … 500 -> $k {
    for @square ->  $f {
        if $k ÷ $f == Int( $k ÷ $f ) {
            %tag{$k}:delete;
            last;
        }
    }
}
say 'The smallest positive square-free integers are';
say %tag.keys.sort(&infix:«<=>»).join( ' ,');
