#!/usr/bin/perl

use strict;
use warnings;
use feature qw(say);

# Input
my $S = "The purpose of our lives is to be happy";

# Output
$S =~ s/^[^\s]+\s(.*)\s[^\s]+$/$1/;
$S =~ s/\s//g;

say length($S);