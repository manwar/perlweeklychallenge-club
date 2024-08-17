=begin

Write a script to return true if the square is light, and false if the square is dark.

Example 1
Input: $coordinates = "d3"
Output: true
Example 2
Input: $coordinates = "g5"
Output: false
Example 3
Input: $coordinates = "e6"
Output: true

=cut

use strict;
use warnings;
use Data::Dumper;
my @columns_let = ('a'..'h');
my %letters;

for(my $i=1; $i<=(scalar @columns_let);$i++){
  $letters{$columns_let[$i-1]} = $i;
}

my @tiles = ('d3','g5','e6');

foreach(@tiles){
  my ($let,$num) = $_ =~ /(\w+)(\d+)/;
  if( ($letters{$let} + $num) % 2 == 0 ){
    print "$let$num -> False\n";
  }else{
    print "$let$num -> True\n";
  }
}