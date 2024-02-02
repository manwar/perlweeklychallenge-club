#!/usr/bin/env perl
use strict;
use warnings;

sub reverse_vowels{
  my ($str) = @_;
  my @vowels = $str =~ /[aeiou]/gi;
  $str =~ s/([aeiou])/pop @vowels/egi;
  ucfirst $str
}

printf "%s\n",reverse_vowels('Raku');
printf "%s\n",reverse_vowels('Perl');
printf "%s\n",reverse_vowels('Julia');
printf "%s\n",reverse_vowels('Uiua');

