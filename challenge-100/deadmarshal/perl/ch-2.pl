#!/usr/bin/perl
use strict;
use warnings;
use List::Util qw(min);
use feature 'say';
use JSON::PP qw(decode_json);

die "No argument provided. " unless @ARGV == 1;

my $arrayref = decode_json shift;
my $sum;

foreach my $item (@$arrayref){
  $sum += min @$item;
}

say $sum;
