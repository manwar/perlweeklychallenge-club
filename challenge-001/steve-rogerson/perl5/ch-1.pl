#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
use 5.022;

my $string = "Perl Weekly Challenge";

my $count = 0;
$string =~ s/e/{ ++$count; 'E'}/ge;

say "$string: $count";
