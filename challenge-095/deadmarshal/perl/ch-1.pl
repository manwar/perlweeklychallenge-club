#!/usr/local/bin/perl
use strict;
use warnings;
use feature 'say';

my $N = $ARGV[0] || 2332;

if($N == reverse $N){
  say 1;
}else{
  say 0;
}

