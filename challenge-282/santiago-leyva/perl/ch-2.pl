=begin

You are given an alphabetic string, $str, as typed by user.

Write a script to find the number of times user had to change the key to type the given string. 
Changing key is defined as using a key different from the last used key. The shift and caps lock keys won’t be counted.

Example 1
Input: $str = 'pPeERrLl'
Ouput: 3

p -> P : 0 key change
P -> e : 1 key change
e -> E : 0 key change
E -> R : 1 key change
R -> r : 0 key change
r -> L : 1 key change
L -> l : 0 key change
Example 2
Input: $str = 'rRr'
Ouput: 0
Example 3
Input: $str = 'GoO'
Ouput: 1

=cut

my @strings = ('pPeERrLl','rRr','GoO','hHannah');

foreach(@strings){
  my $key_change = findKeyChange($_)."\n";
  print $key_change;
}

sub findKeyChange {
  my $_string = shift;
  my @lower_string = split("",$_string);
  @lower_string = map{
    lc $_;
  }@lower_string;
  my $change = -1;
  
  for(my $i=0;$i<(scalar @lower_string);$i++){
    if($lower_string[$i] ne $lower_string[$i+1]){
      $change++;
    }
  }

  return $change;
}