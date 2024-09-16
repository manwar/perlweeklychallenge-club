=begin

You are given a positive integer, $int, having 3 or more digits.

Write a script to return the Good Integer in the given integer or -1 if none found.

A good integer is exactly three consecutive matching digits.

Example 1
Input: $int = 12344456
Output: "444"
Example 2
Input: $int = 1233334
Output: -1
Example 3
Input: $int = 10020003
Output: "000"

=cut

my @nums = (12344456,1233334,10020003);

foreach(@nums){
  my $good = Findgoodinteger($_);
  print $good."\n";
}

sub Findgoodinteger {
  my $number = shift;
  my @num_list = split("",$number);
  #print join("",@num_list)."\n";
  my $result .= @num_list[0];
  for(my $i=0; $i<(scalar @num_list);$i++){

    if(length($result) == 3 and ($num_list[$i+1] != $num_list[$i])){
      return $result;
    }
    #print "$num_list[$i] == $num_list[$i+1] $result \n";
    if($num_list[$i] == $num_list[$i+1]){
      $result .= $num_list[$i];
    }else{
      $result = '';
      $result .= $num_list[$i+1];
    }
    
    
  }
  return -1;

}