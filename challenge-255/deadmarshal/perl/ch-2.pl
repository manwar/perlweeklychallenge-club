#!/usr/bin/env perl
use strict;
use warnings;

sub most_frequent_word{
  my %h;
  map{$h{$_}++ if $_ ne $_[1]}split /[^\w]/,$_[0];
  (sort{$h{$b}<=>$h{$a}}keys %h)[0]
}

printf "%s\n",most_frequent_word("Joe hit a ball, the hit ball ".
				 "flew far after it was hit.",
				 "hit");
printf "%s\n",most_frequent_word("Perl and Raku belong to the same family.".
				 " Perl is the most popular language ".
				 "in the weekly challenge.",
				 "the");

