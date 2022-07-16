#!/usr/bin/env perl
use strict;
use warnings;

die "No args provided!" unless @ARGV == 1 && $ARGV[0] =~ /\d+/;

sub is_esthetic_number{
  my ($n) = @_;
  use integer;
  my $uabs = sub{
    if($_[0] < $_[1]){
      return $_[1] - $_[0];
    }
    return $_[0] - $_[1];
  };

  if($n == 0){return 0}
  my $i = $n % 10;
  $n /= 10;
  while($n){
    my $j = $n % 10;
    if($uabs->($i, $j) != 1){
      return 0;
    }
    $n /= 10;
    $i = $j;
  }
  return 1;
}

print is_esthetic_number($ARGV[0]) ? "True" : "False", "\n";
