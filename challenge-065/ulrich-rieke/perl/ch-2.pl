#!/usr/bin/perl ;
use strict ;
use warnings ;
use Algorithm::Combinatorics qw ( subsets ) ;

sub arraysum {
  my $array = shift ;
  my $sum = 0 ;
  for my $i ( @{$array} ) {
      $sum += $i ;
  }
  return $sum ;
}

#function is applied only to strings with a minimum length of 1
#provides all possible letter combination with a minimum length of 2 for
#a palindrome
sub findAllLengthCombinations {
  my $string = shift ;
  my $len = length $string ;
  my @lengths ;
  my @combis ;
  if ( $len > 1 ) {
      @lengths = (1..$len) ;
      my $iter = subsets ( \@lengths ) ;
      while ( my $p = $iter->next ) {
    if ( arraysum( $p ) <= $len ) {
        push ( @combis , $p ) ;
    }
      }
  }
  return @combis ;
}

sub isPalindrome {
  my $str = shift ;
  my $reversed = join( '', reverse split( // , $str ) ) ;
  return ( length $str > 1 && $str eq $reversed ) ;
}

#find substrings according to the length combinations provided by the
#subsets of possible indices
sub findSubstrings {
  my $positions = shift ;
  my $str = shift ;
  my @substrings ;
  my $currentpos = 0 ;
  while (@{$positions}) {
      my $posadvance = shift @{$positions} ;
      if ( $posadvance != 0 ) {
    push ( @substrings , substr( $str , $currentpos, $posadvance ) ) ;
    $currentpos += $posadvance ;
      }
  }
  return @substrings ;
}

my $string = $ARGV[0] ;
my $len = length $string ;
my @lengthcombis = findAllLengthCombinations( $string ) ;
my @palindromicPartitions ;#contains all palindrome partitions with more than
#1 word
my %palindromeWords ; #counts all palindromic words found
foreach my $combi ( @lengthcombis ) {
  my @substrings = findSubstrings( $combi , $string ) ;
  my @palindromes = grep { isPalindrome( $_) } @substrings ;
  if ( @palindromes ) {
      if ( scalar @palindromes == 1 ) {
    $palindromeWords{ $palindromes[0] }++ ;
      }
      else {
    push ( @palindromicPartitions ,  join( ',' , @palindromes ) ) ;
    map {$palindromeWords{$_}++} @palindromes ;
      }
  }
}
my @letters = ('a'..'z') ;
#if a palindromic substring occurs only once it is only taken account of if it
#appears at the start of the string. Whenever there are 2 and more consecutive
#palindromic substrings they are considered as a solution
my @only_once = grep { $palindromeWords{$_} == 1 && index( $string , $_) == 0 }
keys %palindromeWords ;
my $solutions = scalar @only_once + scalar @palindromicPartitions ;
if ( $solutions > 0 ) {
  print "There are $solutions possible solutions.\n" ;
  my $i = 0 ;
  foreach my $solution ( @only_once ) {
      print "$letters[ $i ]) $solution\n" ;
      $i++ ;
  }
  foreach my $solution( @palindromicPartitions ) {
      print "$letters[ $i ]) $solution\n" ;
      $i++ ;
  }
}
else {
  print "-1\n" ;
}
