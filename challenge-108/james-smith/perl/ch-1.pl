#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

my $scalar = 1;
my @array  = (1);
my %hash   = (1=>1);
my $arrayref = \@array;
my $hashref  = \%hash;
my $scalarref  = \$scalar;

say "Scalar ", get_loc( \$scalar );
say "Scalarref ", get_loc( \$scalarref );
say "Array ", get_loc( \@array );
say "Arrayref ", get_loc( \$arrayref );

sub get_loc {
  return $_[0] =~ s{(?:.*\(|\))}{}rg;
}

