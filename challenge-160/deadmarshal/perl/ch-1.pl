#!/usr/bin/env perl
use strict;
use warnings;
use Lingua::EN::Numbers qw(num2en);

die "No args provided!" unless @ARGV == 1;
die "$ARGV[0] must be less than 10!" if $ARGV[0] > 10;

sub four_is_magic{
  my ($n) = @_;
  my @arr;
  my $len = length(num2en($n));
  do{
    push @arr, num2en($n) . ' is ' . num2en($len);
    $n = $len;
    $len = length(num2en($n));
  }until($n == 4);
  push @arr, "four is magic.";
  return ucfirst join ', ', @arr;
}

print four_is_magic($ARGV[0]);
