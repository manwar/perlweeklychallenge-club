#!/usr/bin/env perl
use strict;
use warnings;

unless((defined $ARGV[0]) && ($ARGV[0] =~ m{\d+})){
  print STDERR "No args provided or arg isn't numeric!\n";
  exit(1);
}

sub factorial{
  my $n = shift;
  if($n == 0){return 1;}
  else{return $n * factorial($n-1);}
}

sub factorions{
  my ($n) = @_;
  use integer;
  my $sum = 0;
  do{
    $sum += factorial($n % 10);
    $n /= 10;
  }while($n != 0);

  return $sum == $_[0];
}

print factorions($ARGV[0]) ? 1 : 0;
