#!/usr/bin/env perl
use strict;
use warnings;
use File::Slurp;

sub self_spammer{
  my @words = grep /\S/,split /\s/, read_file(__FILE__);
  $words[rand @words]
}

print self_spammer();

