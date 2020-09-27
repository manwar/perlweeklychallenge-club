#!/usr/bin/env perl

use strict;
use warnings;
use v5.30;

my $N = shift // 4;

my $sum = 0;
$sum += length(sprintf('%b', $_) =~ y/0//dr) for (0..$N);

say "$sum % 1000000007 = ", $sum % 1000000007;
