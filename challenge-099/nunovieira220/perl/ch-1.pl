#!/usr/bin/perl

use strict;
use warnings;
use feature qw(say);

# Input
my $S = "abcde";
my $P = "a*c?e";

# Pattern Match
$P =~ s/(\?|\*)/\.$1/g;

my $res = 0;
$res = 1 if ($S =~ m/^${P}$/);

# Output
say($res);
