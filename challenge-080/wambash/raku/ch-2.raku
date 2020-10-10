#!/usr/bin/env raku
sub count-while ( @n, &f, Bool :$end ) {
    $end ?? @n.reverse !! @n
    andthen .map: { .&f || last }\
    andthen .elems
}

sub count-candies ( +@n ) {
    my @m = (@n Zcmp @n[1..*]);
    @n.keys
    andthen .map: {
        @m[0 .. $_-1].&count-while( * eqv Less, :end )
        max
        @m[$_ .. *].&count-while( * eqv More )
    }\
    andthen .map: * + 1
    andthen .sum
}

multi MAIN ( **@n ) {
    say count-candies(@n)
}

multi MAIN ( :$test! ) {
    use Test;
    is count-candies(1, 4, 3, 2),(1,3,2,1).sum;
    is count-candies(1, 2, 2),   (1,2,1).sum;
    is count-candies(11, 12, 22, 1, 2, 14, 3, 2, 1, -1),   (1,2,3,1,2,5,4,3,2,1).sum;
    is count-candies(<a b c e d>), (1,2,3,4,1).sum;
    done-testing;
}
