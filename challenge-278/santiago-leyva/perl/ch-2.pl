=begin
You are given a word, $word and a character, $char.

Write a script to replace the substring up to and including $char with its characters sorted alphabetically. If the $char doesn’t exist then DON'T do anything.

Example 1
Input: $str = "challenge", $char = "e"
Ouput: "acehllnge"
Example 2
Input: $str = "programming", $char = "a"
Ouput: "agoprrmming"
Example 3
Input: $str = "champion", $char = "b"
Ouput: "champion"

=cut

use strict;
use warnings;
use Data::Dumper;

my @words = (["challenge","e"],
             ["programming","a"],
             ["champion","b"]
             );

foreach my $i (@words){
  replaceSubstr($i);
}

sub replaceSubstr {

  my $input = $_[0];
  my @str = @$input;
  my @word = split("",$str[0]);
  my @sorted;
  my $char = $str[1];
  my $i = 0;
  my $flag = 0;
  while(($i < (scalar @word))){
    if($word[$i] eq $char){ $flag = 1; last;}
    push @sorted, $word[$i];
    $i++;
  }
  @sorted = sort @sorted;
  if($flag == 1){
    splice(@word,0,$i,@sorted);
  }
  print join("",@word)."\n";

}