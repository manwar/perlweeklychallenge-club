=begin

You are given a string, $str, where every two consecutive vertical bars are grouped into a pair.

Write a script to return the number of asterisks, *, excluding any between each pair of vertical bars.

Example 1
Input: $str = "p|*e*rl|w**e|*ekly|"
Ouput: 2
The characters we are looking here are "p" and "w**e".

Example 2
Input: $str = "perl"
Ouput: 0

Example 3
Input: $str = "th|ewe|e**|k|l***ych|alleng|e"
Ouput: 5

The characters we are looking here are "th", "e**", "l***ych" and "e".

=cut

use strict;
use warnings;
use Data::Dumper;

my @str = ("p|*e*rl|w**e|*ekly|","perl","th|ewe|e**|k|l***ych|alleng|e");

foreach(@str){
  my $result = findasterik($_);
  print "$_ -> $result\n";
}


sub findasterik {
  my $string = shift;
  my @A = split("",$string);
  my @A_split;
  my $temp;
  my $pos = 0;
  my $asterik;
  foreach(@A){
    
    if($_ eq '|'){
      @A_split[$pos] = $temp;
      $pos++;
      $temp = '';
      next;
    }
    $temp .= $_;
  }

  my $occurance = 0;
  
  for(my $i=0;$i<(scalar @A_split);$i+=2){
    $asterik = () = @A_split[$i] =~ /\*/g;
    $occurance += $asterik;
  }

  return $occurance;

}