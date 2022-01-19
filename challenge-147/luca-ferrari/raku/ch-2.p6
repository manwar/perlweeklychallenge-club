#!raku

 sub MAIN( Int $limit = 3000 ) {

     my ( %pentagons, %inverse-pentagons );
     %pentagons{ $_ } = ( $_ * ( 3 * $_ - 1 ) / 2 ) for 1 .. $limit;
     %inverse-pentagons{ %pentagons{ $_ } } = $_ for %pentagons.keys.sort;



     for %pentagons.keys.sort -> $index-left {
         for %pentagons.keys.sort -> $index-right {
             next if $index-left == $index-right;


             my ( $sum, $diff ) = %pentagons{ $index-left } + %pentagons{ $index-right },
                                                            abs( %pentagons{ $index-left } - %pentagons{ $index-right } );

             # this is too slow, therefore I use an inverse hash!
             # next if ! %pentagons.values.grep( * ~~ $sum );
             # next if ! %pentagons.values.grep( * ~~ $diff );
             next if %inverse-pentagons{ $diff }:!exists;
             next if %inverse-pentagons{ $sum }:!exists;

             "P( $index-left ) + P( $index-right ) = { %pentagons{ $index-left } } + { %pentagons{ $index-right } } = $sum = P( { %inverse-pentagons{ $sum } } )".say;
             "P( $index-left ) - P( $index-right ) = { %pentagons{ $index-left } } + { %pentagons{ $index-right } } = $diff = P( {%inverse-pentagons{ $diff } } )".say;
             exit;
         }
     }

 }
