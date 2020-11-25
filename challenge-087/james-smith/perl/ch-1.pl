#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Data::Dumper qw(Dumper);

is( display_lcf( lcf(qw(100 4 50 3 2)) ),   '(2, 3, 4)' );
is( display_lcf( lcf(qw(20 30 10 40 50)) ), '0' );
is( display_lcf( lcf(qw(20 19 9 11 10)) ), '(9, 10, 11)' );
is( display_lcf( lcf(reverse 1..100) ), display_lcf(1..100) );

done_testing();

sub display_lcf {
  return @_ ? sprintf '(%s)', join q(, ), @_ : 0;
}

sub lcf {
  my @n = @_;
  my %seq;
  ## Start by collecting together those numbers which
  ## match the criteria of both value and value+1 are
  ## in array...
  foreach my $a (@n) {
    $seq{$a} = $a+1 if grep {$_==$a+1} @n;
  }
  ## Now we are going to collapse the structure;
  ## $seq{$_} exists in %seq we remove it and update
  ## the value of $seq{$_} to that value.
  ## (delete removes element from hash - return value
  ##  is element removed)
  my $flag = 1;
  while($flag) {
    $flag = 0;
    foreach (keys %seq) {
      next unless exists $seq{$_} && exists $seq{$seq{$_}};
      $seq{$_} = delete $seq{$seq{$_}};
      $flag = 1;
    }
  }
  ## Now we look for the longest sequence
  ## (note we only return the first sequence of a given
  ##  length we find)
  my $k = undef;
  foreach ( keys %seq ) {
    $k = $_ if !defined $k || $seq{$_}-$_ > $seq{$k}-$k;
  }
  ## Return it if there is a longest sequence.
  return unless defined $k;
  return $k..$seq{$k};
}

