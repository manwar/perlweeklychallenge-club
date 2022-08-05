use v6;

# AUTHOR: Robert DiCicco
# DATE: 2022-08-01
# Challenge 176 Reversible Numbers ( Raku )

sub MAIN() {

  for 10..^100 -> $num {

    my $newnum = $num.comb.join + $num.comb.reverse.join;

    print "$num " if AllDigitsOdd($newnum);

  }

  print "\n";

}

sub AllDigitsOdd( $d ) {

  my @candidate = $d.comb;

  for ( @candidate ) -> $c {

    if $c % 2 == 0 {

      return False;

    }

  }

  return True;

}
