=begin

You are given a string, $str.

Write a script to split the given string into two containing exactly same number of vowels and return true if you can otherwise false.

Example 1
Input: $str = "perl"
Ouput: false

Example 2
Input: $str = "book"
Ouput: true
Two possible strings "bo" and "ok" containing exactly one vowel each.

Example 3
Input: $str = "good morning"
Ouput: true
Two possible strings "good " and "morning" containing two vowels each or "good m" and "orning" containing two vowels each.

=cut
use strict;
use warnings;
use Data::Dumper;

my @strings = (["perl"],["book"],["good morning"]);

foreach(@strings){
  print vowelCheck($_)."\n";
}

sub vowelCheck {
  my $string_ = shift;
  my $string = @$string_[0];
  my @A = split("",$string);
  my @vowels;

  for(my $i=0;$i<(scalar @A); $i++){
    if($A[$i] =~ /[aeiouAEIOU]/){
      push @vowels,$A[$i];
    }
  }

  return "True" if(scalar @vowels % 2 == 0);
  return "False" if(scalar @vowels % 2 != 0);
}