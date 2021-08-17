#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw ( combinations ) ;
use List::Util qw ( sum ) ;

#finds the numbers not contained in a given combination
sub findComplement {
  my $array = shift ;
  my $numbers = shift ;
  my %arraynumbers ;
  map { $arraynumbers{ $_ }++ } @$array ;
  my @complement = grep { not exists $arraynumbers{$_} } keys %{$numbers} ;
  return @complement ;
}

sub enterArray {
  say "Enter numbers, separated by blanks" ;
  my $line = <STDIN> ;
  chomp $line ;
  my @array = split( /\s+/ , $line ) ;
  return @array ;
}

my @array = enterArray( ) ;
my %numbers ;#stores all numbers entered in a hash to allow for complement finding
map { $numbers{$_}++ } @array ;
my @minimumPartitions ;#for the subsets with the smallest difference of sums
#found so far
my @set = keys %numbers ;
my $len = scalar @set ;
my $limit = int( $len / 2 ) ;#length of one subset
my $difference = 100000 ;#high starting value to enforce new assignment
my $iter = combinations( \@set , $limit ) ;
while ( my $c = $iter->next ) {
  my @firstPart = @$c ;
  my @secondPart = findComplement( \@firstPart , \%numbers ) ;
  my $currentDifference = abs( (sum @firstPart) - (sum @secondPart ) ) ;
  if ( $currentDifference < $difference ) {
      @minimumPartitions = ( ) ;#delete all arrays found so far
      push @minimumPartitions , \@firstPart , \@secondPart ;#insert new ones
      $difference = $currentDifference ;#and update the difference
  }
}
if ( $len % 2 == 1 ) {#same logic as above , but one subset is longer than the
#other
  $iter = combinations( \@set , $limit + 1 ) ;#that leads to a new limit
  while ( my $c = $iter->next ) {
      my @firstPart = @$c ;
      my @secondPart = findComplement( \@firstPart , \%numbers ) ;
      my $currentDifference = abs( (sum @firstPart) - (sum @secondPart ) ) ;
      if ( $currentDifference < $difference ) {
    @minimumPartitions = ( ) ;
    push @minimumPartitions , \@firstPart , \@secondPart ;
    $difference = $currentDifference ;
      }
  }
}
print "Subset 1 = (" ;
say join( ', ' , sort { $a <=> $b } @{$minimumPartitions[0]} ) . ')' ;
print "Subset 2 = (" ;
say join( ', ' , sort { $a <=> $b } @{$minimumPartitions[1]} ) . ')' ;
