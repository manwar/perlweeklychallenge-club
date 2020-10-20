#!/usr/bin/perl

# Perl Weekly Challenge - 083
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-083/
#
# Task 1 - Words Length
#
# Author: Niels 'PerlBoy' van Dijke

use 5.16.3; # CentOS 7 distro version

use strict;
use warnings;

@ARGV = (q(The purpose of our lives is to be happy))
  unless @ARGV;

my $S = join(' ', @ARGV);

die "Three word sentence minimally please"
  unless ($S =~ m#\S+\s+\S+\s+\S+#);

my $R = $S;

# Trim off leading and trailing spaces
# and remove first and last word
$R =~ s/^\s*\S+(.*?)\S+\s*$/$1/;

# Remove all remaining spaces to calculate resulting length
$R =~ s/\s//g;

printf "Input: \$S = '%s'\n", $S;
printf "Output: %d\n", length($R);
