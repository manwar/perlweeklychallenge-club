
#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( min ) ;

sub enterArray {
  say "Enter numbers, separated by blanks , growing 1 element per line, e to end" ;
  my @array ;
  my $line = <STDIN> ;
  chomp $line ;
  while ( $line ne 'e' ) {
      my @row = split( /\s+/ , $line ) ;
      push @array , \@row ;
      $line = <STDIN> ;
      chomp $line ;
  }
  return @array ;
}

my @array = enterArray( ) ;
my $currentIndex = 0 ;
my $len = scalar @array ;
my $sum = 0 ;
for my $i ( 0 .. $len - 1 ) {
  my @row = @{ $array[ $i ]} ;
  if ( scalar @row == 1 ) {
      $sum += $row[ 0 ] ;
  }
  else {
      $sum += min @row[ $currentIndex, $currentIndex + 1] ;
      if ( $row[$currentIndex + 1] < $row[ $currentIndex ] ) {
    $currentIndex++ ;
      }
  }
}
say $sum ;
