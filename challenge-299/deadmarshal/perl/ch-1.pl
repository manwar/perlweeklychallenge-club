#!/usr/bin/env perl
use strict;
use warnings;

sub replace_words{
  my @words = split ' ',$_[1];
  my %roots;
  $roots{$_} = 1 foreach @{$_[0]};
  foreach my $i(0..$#words){
    foreach my $j(1..length $words[$i]){
      my $sub = substr $words[$i],0,$j;
      if(defined $roots{$sub}){
	$words[$i] = $sub;
	last
      }
    }
  }
  join ' ',@words
}

printf "%s\n",replace_words(['cat', 'bat', 'rat'],
			    'the cattle was rattle by the battery');
printf "%s\n",replace_words(['a','b','c'],
			    'aab aac and cac bab');
printf "%s\n",replace_words(['man','bike'],
			    'the manager was hit by a biker');

