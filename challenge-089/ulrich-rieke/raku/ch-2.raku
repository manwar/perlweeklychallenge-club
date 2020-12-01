use v6 ;

my %frequencies ;
    for (1..9) -> $a {
      for (1..9) -> $b {
    for (1..9) -> $c {
        for (1..9) -> $d {
          for (1..9) -> $e {
          for (1..9) -> $f {
            for (1..9) -> $g {
            for (1..9) -> $h {
              for (1..9) -> $i {
                  if ( $a + $b + $c == 15 )
                and ( $d + $e + $f ) == 15
                and ( $g + $h + $i ) == 15
                and ( $a + $d + $g ) == 15
                and ( $b + $e + $h ) == 15
                and ( $c + $f + $i ) == 15
                and ( $a + $e + $i ) == 15
                and ( $c + $e + $g ) == 15 {
                    for (1 .. 9 ) -> $num {
                      %frequencies{$num} = 0 ;
                    }
                    my @numbers = ($a , $b , $c , $d , $e , $f , $g , $h ,
                      $i ) ;
                    @numbers.map( { %frequencies{$_}++ } ) ;
                    if ( all( %frequencies.values ) == 1) {
                      say "[ $a $b $c ]" ;
                      say "[ $d $e $f ]" ;
                      say "[ $g $h $i ]" ;
                      say " " ;
                }
              }
            }
            }
          }
          }
        }
    }
      }
  }
}
