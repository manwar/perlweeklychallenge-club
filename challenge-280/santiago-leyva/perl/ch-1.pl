=begin

You are given a string, $str, containing lowercase English letters only.
Write a script to print the first letter that appears twice.

Example 1
Input: $str = "acbddbca"
Output: "d"

Example 2
Input: $str = "abccd"
Output: "c"

Example 3
Input: $str = "abcdabbb"
Output: "a"

=cut

use strict;
use warnings;
use Data::Dumper;

my @strings = ("acbddbca","abccd","abcdabbb");

foreach(@strings){
  my $result = findletter($_);
  print "$_ -> $result \n";
}

sub findletter {

  my $str = shift;
  my @A = split("",$str);
  my %seen;

  foreach(@A){

    if(!exists($seen{$_})){
    $seen{$_} = "";
    next;
    }elsif(exists($seen{$_})){
    return $_;
    }

  }
}