#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 5;

sub count_vowel{
  my @res;
  my $len = length $_[0];
  foreach my $s(0..$len-1){
    foreach my $l(5..$len-$s){
      my $sub = substr($_[0],$s,$l);
      next unless $sub =~ /^[aeiou]+$/;
      next unless (5 == grep {$sub =~ /$_/} qw(a e i o u));
      push @res,$sub
    }
  }
  \@res
}

is_deeply count_vowel('aeiou'),['aeiou'],'Example 1';
is_deeply count_vowel('aaeeeiioouu'),
  ['aaeeeiioou','aaeeeiioouu','aeeeiioou','aeeeiioouu'],'Example 2';
is_deeply count_vowel('aeiouuaxaeiou'),
  ['aeiou','aeiouu','aeiouua','eiouua','aeiou'],'Example 3';
is_deeply count_vowel('uaeiou'),['uaeio','uaeiou','aeiou'],'Example 4';
is_deeply count_vowel('aeioaeioa'),[],'Example 5';

done_testing();

