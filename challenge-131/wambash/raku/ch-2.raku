#!/usr/bin/env raku

sub find-pairs($search-string, :$delimeters-string='**//<>') {
    my %delimeter{Bool} = $delimeters-string.comb.classify( {$++ %% 2});
    with $search-string {
        .trans( %delimeter.{True}  => '',:c,:d),
        .trans( %delimeter.{False} => '',:c,:d),
    }
}

multi MAIN ( $search-string, :d($delimeters-string)='()[]' ) {
    put find-pairs $search-string, :$delimeters-string
}

multi MAIN (Bool :test($)!) {
    use Test;
    is find-pairs('/* This is a comment (in some languages) */ <could be a tag>'), ('/**/<','/**/>');
    is find-pairs('I like (parens) and the Apple ][', delimeters-string => '""[]()'), ('([', ')]');
    done-testing;
}
