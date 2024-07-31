=begin
You are given a shuffle string, $str.

Write a script to return the sorted string.

** A string is shuffled by appending word position to each word.

Input: $str = "and2 Raku3 cousins5 Perl1 are4"
Output: "Perl and Raku are cousins"

Input: $str = "guest6 Python1 most4 the3 popular5 is2 language7"
Output: "Python is the most popular guest language"

Input: $str = "Challenge3 The1 Weekly2"
Output: "The Weekly Challenge"

=cut

use strict;
use warnings;

my @strings = ("and2 Raku3 cousins5 Perl1 are4",
               "guest6 Python1 most4 the3 popular5 is2 language7",
               "Challenge3 The1 Weekly2");      

foreach(@strings){
    wordSort($_);
}

sub wordSort {

  my $str = shift;
  my @array = split(m/\s+/,$str);
  my @sort;

  foreach(@array){
    my ($word,$num) = $_ =~ /(\w+)(\d+)/g;
    @sort[$num-1] = $word;
  }

  print join(" ",@sort)."\n";

}