#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw ( combinations ) ;
use List::Util qw ( sum ) ;

sub count {
  my $array = shift ;
  my $number = shift ;
  my $counted = 0 ;
  my @lookIn = @$array ;
  for my $elem( @lookIn ) {
      if ( $elem == $number ) {
    $counted++ ;
      }
  }
  return $counted ;
}

my $u = $ARGV[ 0 ] ;
my $v = $ARGV[ 1 ] ;
while ( $u !~ /\A\d+\z/ || $v !~ /\A\d+\z/ ) {
  say "Please enter 2 integers!" ;
  $u = <STDIN> ;
  chomp $u ;
  $v = <STDIN> ;
  chomp $v ;
}
my @ulams ;
push @ulams , $u , $v ;
@ulams = sort { $a <=> $b } @ulams ;
while ( scalar( @ulams ) < 10 ) {
  if ( scalar( @ulams ) == 2 ) {
      push @ulams, $ulams[0] + $ulams[ 1 ] ;
  }
  else {
      my @sums ;
      my $iter = combinations( \@ulams, 2 ) ;
      while ( my $c = $iter->next ) {
    push @sums , sum( @$c ) ;
      }
      my @sorted = sort { $a <=> $b } @sums ;
      my $elements = scalar( @sorted ) ;
      my $i = 0 ;
      while ( $i < $elements ) {
    if ( $sorted[ $i ] > $ulams[ -1 ] && count( \@sorted ,
          $sorted[ $i ] ) == 1 ) {
        push @ulams, $sorted[ $i ] ;
        last ;
    }
    else {
        $i++ ;
    }
      }
  }
}
say join( ',' , @ulams ) ;
