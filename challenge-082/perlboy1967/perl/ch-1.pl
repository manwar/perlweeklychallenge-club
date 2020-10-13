#!/usr/bin/perl

# Perl Weekly Challenge - 082
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-082/
#
# Task 1 - Common Factors
#
# Author: Niels 'PerlBoy' van Dijke

use strict;
use warnings;

@ARGV = qw(16 128) unless scalar @ARGV;

my ($N, $M) = @ARGV;

die '$N and $M must be positive integers and not equal'
  unless (defined $N and $N =~ m#^[1-9][0-9]*$# and
          defined $M and $M =~ m#^[1-9][0-9]*$#);

my @n = factors($N);
my @m = factors($M);

my @i = intersect(\@n, \@m);

printf "\$N = %d\n", $N;
printf "\$M = %d\n", $M;
print "\n";
printf "The %d factors of \$N (%d) %s: %s\n",
       scalar(@n), $N, 
       (scalar @n > 1 ? 'are' : 'is'), 
       join(', ', @n);
printf "The %d factors of \$M (%d) %s: %s\n",
       scalar(@m), $M, 
       (scalar @m > 1 ? 'are' : 'is'), 
       join(', ', @m);
print "\n";
printf "The %d common factors of \$N (%d) and \$M (%d) %s: %s\n\n",
  scalar(@i), $N, $M, 
  (scalar @i > 1 ? 'are' : 'is'), 
  join(", ", @i);

sub factors {
  my ($n) = @_;

  my @d;

  for my $i (1 .. $n) {
    my $d = int($n/$i);
    push(@d, $i) if ($d * $i == $n);
  }

  return @d;
}

sub intersect {
  my ($ar1, $ar2) = @_;

  my %c = map { $_ => 1 } @$ar1;

  return grep { exists $c{$_} } @$ar2;
}

