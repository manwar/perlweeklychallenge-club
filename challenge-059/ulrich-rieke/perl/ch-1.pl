#!/usr/bin/perl ;
use strict ;
use warnings ;

#create 2 partitions of elements less than or greater than k by "grepping"
#through the array. Shifting from the second array preserves the relative
#order
sub reorder {
  my $array = shift ;
  my $k = shift ;
  my @first_part = grep { $_ < $k } @{$array} ;
  my @second_part = grep { $_ >= $k } @{$array} ;
  while ( @second_part ) {
      push( @first_part, shift @second_part ) ;
  }
  return @first_part ;
}

#of n elements in @ARGV, the first n - 1 are the list, the last element is k
my $len = $#ARGV ;
my @array = @ARGV[0..$len - 1 ] ;
my @reordered = reorder (\@array , $ARGV[ -1 ] ) ;
map { print "$_ -> " } @reordered[0..$len - 2] ;
print "$reordered[ -1]\n" ;
