#!/usr/bin/env perl6

my $string = "Perl Weekly Challenge";

my $count = 0;
$string ~~ s:g/e/{ ++$count; 'E'}/;

say "$string: $count";
