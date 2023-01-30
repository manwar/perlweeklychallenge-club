#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub printHorizontal { #logic for horizontal segments
  my $printOrder = shift ;
  my $len = length $printOrder ;
  for my $pos ( 0..$len - 1 ) {
      if ( substr( $printOrder , $pos , 1 ) eq '1' ) {
    print '-' x 7 ;
      }
      else {
    print ' ' x 7 ;
      }
      print ' ' x 3 ; #print interdigit space
  }
  say ' ' ;
}

sub printVertical {#logic for vertical segments which are printed twice
  my $printOrder = shift ;
  my $len = shift ;
  for (1 .. 2 ) {
      for my $pos( 0 .. $len - 1 ) {
    if ( substr( $printOrder , $pos , 1 ) eq '1' ) {
        print '|' ;
    }
    else {
        print ' ' ;
    }
    if ( substr( $printOrder , $pos + $len , 1 ) eq '1' ) {
        print (' ' x 5 . '|' ) ;
    }
    else {
        print ' ' x 6 ;
    }
    print ' ' x 3 ;
      }
      say ' ' ;
  }
}

my $number = $ARGV[0] ;
my @digits ;
while ( $number != 0 ) {
  push @digits , $number % 10 ;
  $number = int( $number / 10 ) ;
}
@digits = reverse @digits ;
my @truth = qw<abcdef bc abdeg abcdg bcfg acdfg a cdefg abc abcdefg abcfg> ;
my @selected ; #which truth table entries represend the digits entered ?
for my $n ( @digits ) {
  if ( $n <= 5 ) {
      push @selected , $truth[ $n ] ;
  }
  else {
      push @selected , $truth[ $n + 1 ] ;
  }
}
my $finalLetterOrder ;
for my $char ( 'a' , 'f' , 'b' , 'g' , 'e' , 'c' , 'd' ) {
  for my $table ( @selected ) {
      my %letters ;
      my @singleLetters = split( // , $table ) ;
      map { $letters{$_}++ } @singleLetters ;
      if ( exists $letters{ $char } ) {
    $finalLetterOrder .= '1' ;
      }
      else {
    $finalLetterOrder .= '0' ;
      }
  }
}
my $len = scalar( @digits ) ;
printHorizontal(substr( $finalLetterOrder , 0 , $len )) ;#segment 'a'
#then segment 'f' and 'b'
printVertical( substr( $finalLetterOrder , $len , 2 * $len ) , $len ) ;
#segment 'g'
printHorizontal( substr( $finalLetterOrder , 3 * $len , $len ) ) ;
#segment 'e' and 'c'
printVertical( substr( $finalLetterOrder , 4 * $len , 2 * $len ) , $len ) ;
#segment 'd'
printHorizontal( substr( $finalLetterOrder , 6 * $len , $len ) ) ;
