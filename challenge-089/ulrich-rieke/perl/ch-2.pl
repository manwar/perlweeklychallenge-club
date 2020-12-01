#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature "say" ;
use List::Util qw( all ) ;

my %frequencies ;
for my $a (1..9)  {
  for my $b (1..9) {
      for my $c (1..9) {
    for my $d (1..9) {
        for my $e (1..9) {
          for my $f (1..9) {
          for my $g (1..9) {
            for my $h (1..9) {
            for my $i (1..9) {
              if (( $a + $b + $c == 15 )
                  and ( $d + $e + $f ) == 15
                  and ( $g + $h + $i ) == 15
                  and ( $a + $d + $g ) == 15
                  and ( $b + $e + $h ) == 15
                  and ( $c + $f + $i ) == 15
                  and ( $a + $e + $i ) == 15
                  and ( $c + $e + $g ) == 15) {
                for my $num (1 .. 9 )  {
                    $frequencies{$num} = 0 ;
                }
                my @numsFound = ( $a , $b , $c , $d , $e , $f , $g ,
                      $h , $i ) ;
                for my $num ( @numsFound ) {
                    $frequencies{$num}++ ;
                }
                if ( all { $_ == 1 } values %frequencies ) {
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
