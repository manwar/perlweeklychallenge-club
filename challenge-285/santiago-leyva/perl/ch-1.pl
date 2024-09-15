=begin
You are given a list of routes, @routes.

Write a script to find the destination with no further outgoing connection.

Example 1
Input: @routes = (["B","C"], ["D","B"], ["C","A"])
Output: "A"

"D" -> "B" -> "C" -> "A".
"B" -> "C" -> "A".
"C" -> "A".
"A".
Example 2
Input: @routes = (["A","Z"])
Output: "Z"
=cut

use strict;
use Data::Dumper;

my @input  = ([["B","C"], ["D","B"], ["C","A"]],[["A","Z"]]);

foreach(@input){
  my $arr = $_;
  my @A = @$arr;
  my $dead_end = findDeadEnd(\@A);
  print $dead_end."\n";
}

sub findDeadEnd {
  my $array = shift;
  my @route = @$array;
  my @origin;
  my @destination;
  my @deadend;
  for(0..scalar @route-1){
    push @origin, $route[$_][0];
  }
  for(0..scalar @route-1){
    push @destination, $route[$_][1];
  }

  foreach my $i (@destination){
    if( !(grep( /^$i$/, @origin)) ){
      push @deadend, $i;
    }
    
  }

  if(scalar @deadend > 1){
    return "There are multiple routes with no outgoing connection";
  }elsif(scalar @deadend == 0){
    return "All routes have an outgoing connection";
  }
  return $deadend[0];
  
}
