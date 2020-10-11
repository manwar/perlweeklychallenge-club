#!/usr/bin/env raku

sub detox (Str $a) {
    $a
    andthen .trans: '."(),' => ''
    andthen .subst: / <[']> s » /, '', :g
    andthen .subst: / '--' /, ' ',:g
}

multi frequency-sort ( IO(Any) :$input-file! ) {
    $input-file
    andthen .slurp
    andthen samewith $_
}

multi frequency-sort ( Str $input ) {
    $input
    andthen .&detox
    andthen .words
    andthen .Bag
    andthen .sort
    andthen .classify: *.value, as => *.key
}

multi MAIN () {
    put frequency-sort slurp() ;
}

multi MAIN ( IO(Str) $file ) {
    put frequency-sort :input-file( $file );
}

multi MAIN ( Bool :$test! ) {
    use Test;
    my $fs = frequency-sort :input-file<input.txt> ;
    is $fs.{9}, <and the>;
    is $fs.{3}, <Maria Tony a can of stop>;
    is $fs.{1}.elems, 84;
    done-testing;
}
