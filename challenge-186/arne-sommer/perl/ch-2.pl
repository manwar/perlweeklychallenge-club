#! /usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature 'say';
use feature 'unicode_strings';
use feature 'signatures';
no warnings 'experimental::signatures';

use Unicode::Normalize;

say makeover('ÃÊÍÒÙ');
say makeover('âÊíÒÙ');

sub makeover ($str)
{
  my $nfkd = NFKD($str);
  $nfkd =~ s/\p{NonspacingMark}//g;
  return Unicode::Normalize::reorder(Unicode::Normalize::decompose($nfkd));
}
