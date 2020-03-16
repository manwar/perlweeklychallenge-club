#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my ($start,$end) = @ARGV;

die ("Usage:\n\tch1.pl <start> <end>\n\n") if @ARGV<2;

my @range = ($start..$end);
my $step  = "123456789";
say "List of stepping number(s) from $start to $end";
"@range " =~ "$& " && say $& while $step =~ s/.(..)/$1/;
=begin
perl .\ch-1.pl 124 780
List of stepping number(s) from 124 to 780
234
345
456
567
678

perl .\ch-1.pl 100 999
List of stepping number(s) from 100 to 999
123
234
345
456
567
678
789
=cut