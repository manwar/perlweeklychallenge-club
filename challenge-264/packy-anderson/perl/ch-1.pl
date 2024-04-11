#!/usr/bin/env perl
use v5.38;

use List::Util qw( maxstr );

sub greatestEnglishLetter($str) {
  my %seen;
  my @greatest;

  # find the characters that exist as both
  # upper and lower case in the string
  foreach my $c ( split //, $str ) {

    # note that we've seen the character
    $seen{$c} = 1;

    # swap the case of the character
    my $C = ($c =~ tr/a-zA-Z/A-Za-z/r);

    # if we've seen the swapped case version of the char,
    # add the uppercase version to our greatest hits
    push @greatest, uc($c) if exists $seen{$C};
  }

  # if we found greatest characters,
  # return the greater of them
  if (@greatest) {
    return maxstr(@greatest);
  }
  # otherwise, return something that
  # represents an empty result
  return q{''};
}

sub solution($str) {
  say "Input: \$str = '$str'";
  my $output = greatestEnglishLetter($str);
  say "Output: $output";
}

say "Example 1:";
solution('PeRlwEeKLy');

say "\nExample 2:";
solution('ChaLlenge');

say "\nExample 3:";
solution('The');