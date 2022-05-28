#!/usr/bin/env perl
#
# pwc_hexwords.pl - Hexwords for PWC
#
# 2022 Ryan Thompson <rjt@cpan.org>

use 5.010;
use File::Slurper qw< read_lines >;

my $dict = $ARGV[0] // '../../../data/dictionary.txt';

say for map {     y/olist/01157/r    }
       grep { /^[0-9a-folist]{2,8}$/ } read_lines($dict);
