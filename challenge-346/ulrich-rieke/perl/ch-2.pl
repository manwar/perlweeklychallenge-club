#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw ( variations_with_repetition ) ;
use List::Util qw ( sum ) ;
use Data::Dumper ;

sub parseTerm {
   my $term = shift ;
   while ( $term =~ s/(\d+)\*(\d+)/$1 * $2/ge ) {
   }
   while ( $term =~ /^(\-?\d+)([+-])(\d+)/ ) {
      my ($a , $op , $b ) = ($1 , $2 , $3) ;
      my $result = eval "$a$op$b" ;
      $term =~ s/^(\-?\d+)([+-])(\d+)/$result/ ;
   }
   return $term ;
}

sub findAllLengthCombinations {
   my $wordlength = shift ;
   my @allCombis ;
   my @numbers = (1..$wordlength - 1) ;
   for my $num( 2..$wordlength ) {
      my $iter = variations_with_repetition( \@numbers , $num ) ;
      while ( my $c = $iter->next ) {
	 if ( sum( @$c ) == $wordlength ) {
	    push( @allCombis , $c ) ;
	 }
      }
   }
   return @allCombis ;
}

sub findOperatorCombinations {
   my $divisions = shift ;
   my @combinators = ('+' , '-' , '*') ;
   my @opCombis ;
   my $iter = variations_with_repetition( \@combinators , $divisions ) ;
   while ( my $c = $iter->next ) {
      push( @opCombis , $c ) ;
   }
   return @opCombis ;
}

sub splitTermAtPositions {
   my $term = shift ;
   my $positions = shift ;
   my $pos = 0 ;
   my @splitTerms ;
   while ( @$positions ) {
      my $len = shift( @$positions ) ;
      my $part = substr( $term , $pos , $len ) ;
      push( @splitTerms , $part ) ;
      $pos += $len ;
   }
   return @splitTerms ;
}

sub combineWithOperators {
   my $splitterms = shift ;
   my $len = scalar( @$splitterms ) ;
   my @opCombinations = findOperatorCombinations($len - 1 ) ;
   my @combis ;
   if ( $len == 2 ) {
      my $total ;
      for my $op ( @opCombinations ) {
	 $total .= $splitterms->[0] . $op->[0] . $splitterms->[1] ;
	 push( @combis , $total ) ;
	 $total = "" ;
      }
   }
   else {
      my $total ;
      for my $combi ( @opCombinations ) {
	 my $pos = 0 ;
	 while ( $pos < $len ) {
	    $total .= $splitterms->[$pos] ;
	    if ( $pos < $len - 1 ) {
	       $total .= $combi->[$pos] ;
	    }
	    $pos++ ;
	 }
	 push( @combis , $total ) ;
	 $total = "" ;
      }
   }
   return @combis ;
}
say "Enter a term consisting of digits only!" ;
my $term = <STDIN> ;
chomp $term ;
say "Enter a number!" ;
my $target = <STDIN> ;
chomp $target ;
if ( $term eq $target ) {
   say '(' . join(',' , ("$term+0" , "$term-0")) . ')' ;
}
else {
   my @allCombis ;
   my @allLengths = findAllLengthCombinations( length( $term ) ) ;
   for my $combi( @allLengths ) {
      my @splitTerm = splitTermAtPositions( $term , $combi ) ;
      my @combisForLength = combineWithOperators( \@splitTerm ) ;
      map { push( @allCombis , $_ ) } @combisForLength ;
   }
   say '(' . join( ',' , grep { parseTerm($_) == $target } @allCombis )  . ')' ;
}
