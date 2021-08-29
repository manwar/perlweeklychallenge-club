#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub findIntersection {
  my $firstSubarray = shift ;
  my $secondSubarray = shift ;
  my %firstHash ;
  for my $i ( $firstSubarray->[0] .. $firstSubarray->[1] ) {
      $firstHash{ $i }++ ;
  }
  for my $i  ($secondSubarray->[0] .. $secondSubarray->[1] ) {
      if ( exists $firstHash{ $i } ) {
    return 1 ;
      }
  }
  return 0 ;
}

say "Enter intervals , i.e. two integers starting with ( and ending with )!" ;
say "Enter end to end!" ;
my @intervals ;
my $line = <STDIN> ;
chomp $line ;
while ( $line ne "end" ) {
  my $smaller ;
  my $greater ;
  if ( $line =~ /\A\((\d+)\,(\d+)\)\z/ ) {
      if ( $1 < $2 ) {
    $smaller = $1 ;
    $greater = $2 ;
      }
      else {
    $smaller = $2 ;
    $greater = $1 ;
      }
  }
  else {
      say "Enter integers , starting with ( and ending with )" ;
  }
  if ( $smaller && $greater ) {
      push ( @intervals , [$smaller , $greater] ) ;
  }
  $line = <STDIN> ;
  chomp $line ;
}
my @solutions ;
my $len = scalar @intervals ;
for my $i ( 1 .. $len - 1 ) {
  for my $j ( 0 .. $i - 1 ) {
      if ( findIntersection( $intervals[ $i ] , $intervals[ $j ] ) ) {
    push @solutions, $intervals[ $i ] ;
    last ;
      }
  }
}
print '[' ;
for my $interv ( @solutions ) {
  print '(' . $interv->[0] . ',' . $interv->[1] . ')' ;
  if ( $interv != $solutions[ -1 ] ) {
      print ',' ;
  }
}
say ']' ;
