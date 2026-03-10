#!/usr/bin/env perl

use Modern::Perl;
use List::Util 'max';

my @ints = @ARGV;
say max(scalar(grep {$_>0} @ints), scalar(grep {$_<0} @ints));
