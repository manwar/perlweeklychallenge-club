#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(all);
use Set::Scalar;

sub keyboard_word{
  my ($arr) = @_;
  my ($s1,$s2,$s3) = (Set::Scalar->new(split '',"qwertyuiop"),
		      Set::Scalar->new(split '',"asdfghjkl"),
		      Set::Scalar->new(split '',"zxcvbnm"));
  my @ret;
  @$arr = map {lc} @$arr;
  foreach my $str(@$arr){
    foreach my $set($s1,$s2,$s3){
      if(all {$set->has($_)} split '',$str){push @ret,$str}
    }
  }
  @ret;
}

printf "(%s)\n", join ' ',
  keyboard_word(["Hello","Alaska","Dad","Peace"]);
printf "(%s)\n", join ' ', keyboard_word(["OMG","Bye"]);

