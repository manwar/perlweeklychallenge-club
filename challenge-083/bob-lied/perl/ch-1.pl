#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl
#=============================================================================
# Copyright (c) 2020, Bob Lied
#=============================================================================
# Perl Weekly Challenge 083 Task #1 > Words Length
#=============================================================================
# You are given a string $S with 3 or more words.
# Write a script to find the length of the string except the first and last words
# ignoring whitespace.

use strict;
use warnings;
use v5.30;

use experimental qw/ signatures /;

use Getopt::Long;

sub Usage { "Usage: $0 'string of words'" };

my $Verbose = 0;
GetOptions('verbose' => \$Verbose);

my $S = shift;

die Usage() unless $S;

# Trim leading white space.
$S =~ s/^\s+//;

# Remove the first word -- anything that's not white space
$S =~ s/^\S+//;

# Turn the string around.
$S = reverse($S);

# Trim leading white space.
$S =~ s/^\s+//;

# Remove the first word again.
$S =~ s/^\S+//;

# Ignore white space.
$S =~ s/\s*//g;

say length($S);
