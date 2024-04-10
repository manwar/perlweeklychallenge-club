#!/usr/local/bin/env perl
use strict;
use warnings;
use Set::Scalar;
use List::Util qw(maxstr);

sub greatest_english_letter{
  my $s1 = Set::Scalar->new;
  my $s2 = Set::Scalar->new;
  map{$_ le 'Z' ? $s1->insert($_) : $s2->insert(uc $_)} split '',$_[0];
  maxstr($s1->intersection($s2)->members) // ''
}

printf "%s\n", greatest_english_letter('PeRlwEeKLy');
printf "%s\n", greatest_english_letter('ChaLlenge');
printf "%s\n", greatest_english_letter('The');

