#!/usr/bin/perl

use strict;
use warnings;
use List::Util qw(reduce);
use Storable qw(dclone);
use Data::Dumper::OneLine;

# Input
my @N = (5, 2, 1, 4, 3);

# Array of Product
my @res = ();

for(my $i = 0; $i < scalar @N; $i++) {
  my @aux = @{dclone(\@N)};
  splice(@aux, $i, 1);
  push @res, reduce { $a * $b } @aux;
}

# Output
print Dumper(\@res);