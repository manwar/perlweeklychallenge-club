#!/usr/bin/env perl
#
# ch-1.pl - s/e/E/g
#
# 2019 Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;

my $str = 'Perl Weekly Challenge';
my $count = $str =~ tr/e/E/;

say "$str -> e x $count";
