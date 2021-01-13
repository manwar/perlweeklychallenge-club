#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

## Usage
#
# perl ch-1-list-iso-words.pl {n} < wordlist.txt
#
# Where wordlist is a list of lowercased words with no hyphens etc
#
# {n} is optional if 0 - it lists all words
# {n} > 0 lists all words who have {n} or more repeated characters e.g. abba has two eerie has two

my $filter = 0;
$filter = $ARGV[0] if @ARGV;
my %words;

while(<STDIN>) {
  chomp;
  ## Initialise letter cache and "counter"
  next if 1 == length $_;
  my($x,%m)='a';
  push @{$words{join '',  ## Stitch back the word and return it....
    map { $m{$_}||=$x++ } ## Return letter from cache (or next letter)
    split m{}, $_         ## Split into individual characters
  }}, $_;
}

foreach ( sort { (length($a)<=> length($b)) || (reverse($a) cmp reverse($b)) } keys %words) {
  next if @{$words{$_}} <2;
  if( $filter > 0 ) {
    my %t;
    %t = map { $_=>1 } split m{}, $_;
    my $l = scalar keys %t;
    next unless $l < length($_) - $filter -1;
  }
  printf "%4d : %4d : %5d : %20s : %s\n",
    length $_, length($_)-$l, (scalar @{$words{$_}}), $_, "@{$words{$_}}";
}

