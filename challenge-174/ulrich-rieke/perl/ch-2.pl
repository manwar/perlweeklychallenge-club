#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw ( permutations ) ;
use List::Util qw ( reduce uniq ) ;

sub arrayToString {
  my $array = shift ;
  my @numbers = @$array ;
  return reduce { $a . $b } @numbers ;
}

sub permutation2rank {
  my $array = shift ;
  my @numbers = @$array ;
  my @permutations = permutations( \@numbers ) ;
  my @strings = map { arrayToString( $_ ) } @permutations ;
  my @sorted = sort { $a cmp $b } @strings ;
  my $str = arrayToString( \@numbers ) ;
  my $i = 0 ;
  while ( $sorted[ $i ] ne $str ) {
      $i++ ;
  }
  return $i ;
}

sub rank2permutation {
  my $array = shift ;
  my @numbers = @$array ;
  my $rank = shift ;
  my %permuHash ;
  my @permutations = permutations( \@numbers ) ;
  my @strings ;
  for my $ar ( @permutations ) {
      my $str = arrayToString( $ar ) ;
      $permuHash{ $str } = $ar ;
      push @strings , $str ;
  }
  my @sorted = sort { $a cmp $b } @strings ;
  if ( $rank > $#sorted ) {
      say "There are no $rank ranks in the permutation list!" ;
      return ;
  }
  else {
      return @{$permuHash{ $sorted[ $rank ] }} ;
  }
}

say "Enter some integers, separated by a blank!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s+/ , $line ) ;
my @uniques = uniq @numbers ;
my $num = permutation2rank( \@uniques ) ;
say "permutation2rank([" . join( ", " , @uniques ) . "]) = $num" ;
say "Which rank of the permutations do you want to find ?" ;
$line = <STDIN> ;
chomp $line ;
while ( $line !~ /^(\d+)$/ ) {
  say "Only integers are admitted! Re-enter!" ;
  $line = <STDIN> ;
  chomp $line ;
}
my @rankFound = rank2permutation(\@numbers , $line ) ;
if ( @rankFound ) {
  say "rank2permutation([" . join( ", " , @uniques ) . "], $line) = ["
      . join( ", " , @rankFound ) . "]" ;
}
