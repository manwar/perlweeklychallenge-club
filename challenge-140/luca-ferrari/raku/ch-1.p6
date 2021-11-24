#!raku

sub MAIN( Int $a where { $a > 0 && $a ~~ /^ <[01]>+ $/ } ,
          Int $b where { $b > 0 && $b ~~ /^ <[01]>+ $/ } ) {

    $_.base( 2 ).say given $a.parse-base( 2 ) + $b.parse-base( 2 );
}
