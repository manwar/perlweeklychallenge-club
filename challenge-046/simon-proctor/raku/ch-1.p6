#!/usr/bin/env raku

my @test1 = (<H x l 4 !>,
             <c e - l o>,
             <z e 6 l g>,
             <H W l v R>,
             <q 9 m # o>);

die "Decoder is bust" unless decode-message( @test1 ) ~~ "Hello";

my @message = (
    <P + 2 l ! a t o>,
    <1 e 8 0 R $ 4 u>,
    <5 - r ] + a \> />,
    <P x w l b 3 k \\>,
    <2 e 3 5 R 8 y u>,
    <\< ! r ^ ( ) k 0>,
    );

say decode-message( @message );

sub decode-message( $data ) {
    zip( $data.List ).map( { Bag.new($_) } ).map( *.pairs.sort( { $^b.value cmp $^a.value } ).first.key ).join("")
}
