#!/usr/bin/env perl

use 5.026;
use strict;
use warnings;
use Math::MatrixReal;

my $n = shift or die "Usage: $0 N\n";

my $matrix = Math::MatrixReal->new_diag([(1) x $n]);

say $matrix;
